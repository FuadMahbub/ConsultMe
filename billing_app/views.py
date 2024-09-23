from django.shortcuts import render
from django.urls import reverse
from django.views.generic import *
from django.urls import reverse_lazy
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from .models import Invoice
from django.urls import reverse
from django.contrib import messages
import io
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from django.shortcuts import get_object_or_404,redirect
import random
from .forms import PaymentForm
from case_app.models import *
from decimal import Decimal


# Create your views here.
class InvoiceCreateView(LoginRequiredMixin, CreateView):
    model = Invoice
    template_name = 'billing_app/create_invoice.html'
    fields = ['issued_to', 'issued_by', 'amount', 'description']

    def form_valid(self, form):
        form.instance.issued_by = self.request.user.lawyer  # Assumes user is a lawyer
        return super().form_valid(form)

    def get_success_url(self):
        messages.success(self.request, "Invoice Created Successfully...!!")
        return reverse('lawyer:lawyerdashboard')
    # def get_success_url(self):
    #     return reverse_lazy('invoice-detail', kwargs={'pk': self.object.pk})
    
    
    
class ClientInvoiceDetailView(LoginRequiredMixin, UserPassesTestMixin, DetailView):
    model = Invoice
    context_object_name = 'invoice'
    template_name = 'billing_app/client_invoice_detail.html'

    def test_func(self):
        # Ensures that the logged-in user is the client issued to the invoice
        invoice = self.get_object()
        return invoice.issued_to.user == self.request.user

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        invoice = self.get_object()
        context['invoice'] = invoice

        # Check if there is a related case and gather all necessary details
        if invoice.case:
            context['case'] = invoice.case
            context['total_fee'] = invoice.case.total  # Total fee from the case
            context['total_paid'] = invoice.amount  # Total amount paid, reflected in the invoice
            context['payment_due'] = invoice.case.total - invoice.amount  # Calculating the due amount

            # Setting status to paid if no amount is due or unpaid otherwise
            context['invoice_status'] = 'paid' if context['payment_due'] <= 0 else 'unpaid'
        else:
            context['case'] = None
            context['total_fee'] = 0
            context['total_paid'] = 0
            context['payment_due'] = 0
            context['invoice_status'] = 'no case linked'

        return context

class LawyerInvoiceDetailView(LoginRequiredMixin, UserPassesTestMixin, DetailView):
    model = Invoice
    context_object_name = 'invoice'
    template_name = 'billing_app/lawyer_invoice_detail.html'

    def test_func(self):
        # Ensures that the logged-in user is the lawyer who issued the invoice
        invoice = self.get_object()
        return invoice.issued_by.user == self.request.user

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        invoice = self.get_object()
        context['invoice'] = invoice

        if invoice.case:
            context['case'] = invoice.case
            context['total_fee'] = invoice.case.total
            context['total_paid'] = invoice.amount
            context['payment_due'] = invoice.case.total - invoice.amount if invoice.case.total > invoice.amount else 0
            context['invoice_status'] = 'paid' if context['payment_due'] <= 0 else 'unpaid'
        else:
            context['case'] = None
            context['total_fee'] = 0
            context['total_paid'] = 0
            context['payment_due'] = 0
            context['invoice_status'] = 'no case linked'

        context['user_type'] = 'lawyer'  # Adds the user type context for potential conditional rendering in the template
        return context
    
    



class ProcessPaymentView(LoginRequiredMixin, FormView):
    template_name = 'billing_app/payment.html'
    form_class = PaymentForm

    def dispatch(self, request, *args, **kwargs):
        self.case = get_object_or_404(Case, id=self.kwargs['case_id'])
        # Ensure corresponding invoice exists or create one
        self.invoice, created = Invoice.objects.get_or_create(
            case=self.case,
            issued_to=self.case.client,
            issued_by=self.case.lawyer,
            defaults={'amount': Decimal('0.00'), 'status': 'unpaid'}
        )
        return super().dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        payment_amount = form.cleaned_data['amount']
        card_number = form.cleaned_data['card_number']

        # Simulate or integrate actual payment processing
        payment_successful = True  # This would typically be a call to a payment gateway

        if payment_successful:
            self.invoice.amount += payment_amount
            self.invoice.card_last_four = card_number[-4:]
            self.invoice.payment_reference = f'PAY-{random.randint(1000, 9999)}'
            self.invoice.status = 'paid' if self.invoice.amount >= self.case.total else 'unpaid'
            self.invoice.save()

            messages.success(self.request, 'Payment successful!')
            return redirect('billing:clientinvoice_detail', pk=self.invoice.id)
        else:
            messages.error(self.request, "Payment failed, please try again.")
            return self.form_invalid(form)

    def get_form_kwargs(self):
        kwargs = super().get_form_kwargs()
        # Recalculate the due amount based on the current state of the invoice
        current_due_amount = max(Decimal('0.00'), self.case.total - self.invoice.amount)
        kwargs['initial'] = {'amount': current_due_amount}
        return kwargs
    

def download_invoice(request, invoice_id):
    # Fetch the invoice using the ID
    invoice = get_object_or_404(Invoice, id=invoice_id)

    # Create a file-like buffer to receive PDF data
    buffer = io.BytesIO()

    # Create the PDF object, using the buffer as its "file."
    p = canvas.Canvas(buffer, pagesize=letter)
    width, height = letter  # Get page width and height

    # Title and Header
    p.setFont("Helvetica-Bold", 14)
    p.drawString(30, 800, "Invoice Details")
    p.setFont("Helvetica", 12)
    p.drawString(30, 780, f"Invoice ID: {invoice.id}")
    p.drawString(30, 760, f"Issued To: {invoice.issued_to.user.email}")
    p.drawString(30, 740, f"Issued By: {invoice.issued_by.user.email}")

    # Invoice Content
    p.drawString(30, 700, f"Amount Due: ${invoice.amount:.2f}")
    p.drawString(30, 680, f"Description: {invoice.description[:100]}...")  # Truncate long descriptions
    p.drawString(30, 660, f"Status: {invoice.status}")
    p.drawString(30, 640, f"Issued on: {invoice.created_at.strftime('%Y-%m-%d')}")
    p.drawString(30, 620, f"Last Updated: {invoice.updated_at.strftime('%Y-%m-%d')}")

    # Case Details if available
    if invoice.case:
        p.drawString(30, 600, f"Case ID: {invoice.case.id}")
        p.drawString(30, 580, f"Case Name: {invoice.case.name}")
        p.drawString(30, 560, f"Total Case Fee: ${invoice.case.total:.2f}")
        p.drawString(30, 540, f"Total Paid: ${invoice.amount:.2f}")
        p.drawString(30, 520, f"Amount Remaining: ${invoice.case.total - invoice.amount:.2f}")

    # Add card information
    if invoice.card_last_four:
        p.drawString(30, 500, f"Card Last Four: **** **** **** {invoice.card_last_four}")  # Masked card info

    # Add payment reference if available
    if invoice.payment_reference:
        p.drawString(30, 480, f"Payment Reference: {invoice.payment_reference}")

    # Finalize PDF
    p.showPage()
    p.save()

    # File response
    buffer.seek(0)
    response = HttpResponse(buffer.getvalue(), content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="invoice_{invoice.id}.pdf"'
    return response
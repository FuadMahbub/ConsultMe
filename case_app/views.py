import zipfile
import os
from django.http import HttpResponse, HttpResponseForbidden, HttpResponseRedirect
from django.conf import settings
from django.shortcuts import render
from django.shortcuts import get_object_or_404
from django.contrib import messages
from django.views.generic import *
from .models import *
from django.contrib.auth.mixins import LoginRequiredMixin,UserPassesTestMixin
from django.urls import reverse
from django.urls import reverse_lazy
from .forms import *
from decimal import Decimal
from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required
from billing_app.models import Invoice
# Create your views here.


class LawyerCaseDetailView(LoginRequiredMixin, UserPassesTestMixin, DetailView):
    model = Case
    template_name = 'cases/lawyer_case_detail.html'
    context_object_name = 'case'

    def test_func(self):
        # Ensure only the lawyer associated with the case can view it
        case = self.get_object()
        return self.request.user.lawyer == case.lawyer


class ClientCaseDetailView(LoginRequiredMixin, UserPassesTestMixin, DetailView):
    model = Case
    template_name = 'cases/client_case_detail.html'
    context_object_name = 'case'

    def test_func(self):
        # Ensure only the client associated with the case can view it
        case = self.get_object()
        return self.request.user.client == case.client




class LawyerCaseListView(LoginRequiredMixin, ListView):
    model = Case
    template_name = 'lawyer/case_list.html'
    
    def get_queryset(self):
        return Case.objects.filter(lawyer=self.request.user.lawyer)
    

class ClientCaseListView(LoginRequiredMixin, ListView):
    model = Case
    template_name = 'client/case_list.html'
    
    def get_queryset(self):
        return Case.objects.filter(client=self.request.user.client)
    

    
class CaseListView(LoginRequiredMixin, ListView):
    model = Case
    template_name = 'cases/case_list.html'

    def get_queryset(self):
        if self.request.user.lawyer:
            return Case.objects.filter(lawyer=self.request.user.lawyer)
        else:
            return Case.objects.filter(client=self.request.user.client)
    




class LawyerFileUploadView(LoginRequiredMixin, CreateView):
    model = CaseFile
    fields = ['file', 'description']
    template_name = 'cases/lawyer_upload_file.html'

    def form_valid(self, form):
        case = get_object_or_404(Case, id=self.kwargs['case_id'])
        form.instance.case = case
        form.instance.uploaded_by = self.request.user
        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy('case:lawyer_case', kwargs={'pk': self.kwargs['case_id']})
    

class ClientFileUploadView(LoginRequiredMixin, CreateView):
    model = CaseFile
    fields = ['file', 'description']
    template_name = 'cases/client_upload_file.html'

    def form_valid(self, form):
        case = get_object_or_404(Case, id=self.kwargs['case_id'])
        form.instance.case = case
        form.instance.uploaded_by = self.request.user
        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy('case:client_case_detail', kwargs={'pk': self.kwargs['case_id']})
    



class DownloadReceivedFilesView(LoginRequiredMixin, UserPassesTestMixin, View):
    def get(self, request, *args, **kwargs):
        case = get_object_or_404(Case, id=kwargs['case_id'])

        # Check if user is allowed to download the received files
        if not (request.user == case.lawyer.user or request.user == case.client.user):
            return HttpResponseForbidden("You do not have permission to access these files.")

        # Filter received files
        received_files = CaseFile.objects.exclude(case=case, uploaded_by=request.user)

        # Create a Zip file in memory
        response = HttpResponse(content_type='application/zip')
        zip_filename = f"{case.id}_received_files.zip"
        response['Content-Disposition'] = f'attachment; filename={zip_filename}'

        with zipfile.ZipFile(response, 'w') as zip_file:
            for case_file in received_files:
                filename = os.path.basename(case_file.file.path)
                zip_file.write(case_file.file.path, filename)

        return response

    def test_func(self):
        case = get_object_or_404(Case, id=self.kwargs['case_id'])
        return self.request.user == case.client.user or self.request.user == case.lawyer.user



class CaseCreateView(LoginRequiredMixin, CreateView):
    model = Case
    form_class = CaseCreationForm
    template_name = 'cases/create_case.html'

    def form_valid(self, form):
        client = self.request.user.client
        lawyer = client.acceptedclient_set.first().lawyer  # Assuming one-to-many relation

        # Check if there's already an existing case for this client and lawyer
        existing_case = Case.objects.filter(client=client, lawyer=lawyer).exists()
        if existing_case:
            messages.error(self.request, "You have already created a case with this lawyer.")
            return HttpResponseRedirect(self.request.path_info)  # Reload the form

        form.instance.client = client
        form.instance.lawyer = lawyer
        consultation_post = ConsultationPost.objects.get(lawyer=lawyer)
        days = (form.cleaned_data['end_date'] - form.cleaned_data['start_date']).days + 1
        total_fee = days * consultation_post.consultation_fee
        form.instance.total = total_fee
        form.instance.pay_in_advance = total_fee * Decimal('0.30')
        form.instance.due = total_fee - form.instance.pay_in_advance
        return super().form_valid(form)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        client = self.request.user.client
        if client.acceptedclient_set.exists():
            lawyer = client.acceptedclient_set.first().lawyer
            consultation_post = ConsultationPost.objects.get(lawyer=lawyer)
            context['consultation_fee'] = consultation_post.consultation_fee
        return context

    def get_success_url(self):
        return reverse_lazy('billing:process_payment', kwargs={'case_id': self.object.pk})

class CaseDeleteView(LoginRequiredMixin, DeleteView):
    model = Case
    template_name = "client/delete.html"

    def delete(self, request, *args, **kwargs):
        self.object = self.get_object()
        if self.object.due > 0:
            # If due amount is greater than zero, prevent deletion
            messages.error(self.request, "Cannot delete case as there is an outstanding payment due.")
            return redirect(self.get_success_url())
        else:
            # Proceed with deletion if no due amount
            success_url = self.get_success_url()
            self.object.delete()
            messages.success(self.request, "Case Deleted Successfully.")
            return redirect(success_url)

    def get_success_url(self):
        # Redirect to the client dashboard or appropriate page
        return reverse_lazy('client:client_dashboard')

@login_required
def close_case(request, case_id):
    case = get_object_or_404(Case, pk=case_id, client=request.user.client)

    # Ensure all related invoices are paid before closing the case
    invoices = Invoice.objects.filter(case=case)
    if any(invoice.status != 'paid' for invoice in invoices):
        messages.error(request, "Cannot close case because there is an outstanding payment due.")
        return redirect('case:client_case_detail', pk=case_id)

    # Check if case is already closed
    if hasattr(case, 'closed_case'):
        messages.info(request, "This case is already closed.")
        return redirect('case:client_case_detail', pk=case_id)

    # Create a closed case entry before deleting
    ClosedCase.objects.create(
        case=case,
        lawyer=case.lawyer,
        client=request.user.client,
        closed_at=timezone.now()
    )
    
    # Delete the case
    case.delete()
    
    messages.success(request, "The case has been successfully closed and deleted.")
    return redirect('client:client_dashboard')


class ClosedCaseRatingView(LoginRequiredMixin, UserPassesTestMixin, UpdateView):
    model = ClosedCase
    form_class = ClosedCaseRatingForm
    template_name = 'cases/rate_closed_case.html'
    
    def get_success_url(self):
        return reverse_lazy('client:client_dashboard')  # Redirect to client's case list after rating

    def test_func(self):
        closed_case = self.get_object()
        return self.request.user.client == closed_case.client  # Ensure only the client can rate/review




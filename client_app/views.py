from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.mixins import LoginRequiredMixin
from .models import *
from django.views import View
from django.views.generic.edit import FormView
from .forms import *
from django.views.generic import *
from django.contrib.auth.decorators import login_required
from lawyer_app.models import *
from lawyer_app.forms import *
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.mixins import LoginRequiredMixin
from .models import *
from django.views import View
from django.views.generic.edit import FormView
from .forms import *
from django.views.generic import *
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.views.generic import ListView
from lawyer_app.models import ConsultationPost
from django.urls import reverse_lazy
from billing_app.models import Invoice
from case_app.models import *

# Create your views here.


class AvailableLawyersListView(ListView):
    model = ConsultationPost
    template_name = 'client/available_lawyers.html'  
    context_object_name = 'available_lawyers'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Retrieve accepted lawyer for the current client, if any
        accepted_lawyer = AcceptedClient.objects.filter(client=self.request.user.client).first()
        context['accepted_lawyer'] = accepted_lawyer
        return context

    def get_queryset(self):
        # Filter consultation posts created by lawyers
        queryset = super().get_queryset().exclude(lawyer__isnull=True)
        return queryset
    
class AvailableLawyerProfileView(DetailView):
    model = ConsultationPost
    template_name = 'client/view_profile.html'  
    context_object_name = 'consultation_post'
    

class RequestForConsultationCreateView(LoginRequiredMixin,CreateView):
    model = ConsultationRequest
    form_class = ConsultationRequestForm
    template_name = 'client/request_form.html' 

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["title"] = "Create"
        context["heading"] = "Request Consultancy Post"
        return context
    
    def get_initial(self):
        initial = super().get_initial()
        consultation_post_id = self.kwargs.get('consultation_post_id')
        consultation_post = get_object_or_404(ConsultationPost, id=consultation_post_id)
        initial['lawyer'] = consultation_post.lawyer
        initial['consultation_post'] = consultation_post
        # initial['client'] = self.request.user.client
        return initial
    
    def form_valid(self, form):
        consultation_post_id = self.kwargs.get('consultation_post_id')
        client = self.request.user.client
        lawyer = ConsultationPost.objects.get(id=consultation_post_id).lawyer

        # Check if a consultation request with the same client and lawyer already exists
        if ConsultationRequest.objects.filter(client=client, lawyer=lawyer).exists():
            messages.error(self.request, "You have already requested this lawyer for consultancy.")
            return self.form_invalid(form)

        form.instance.consultation_post = ConsultationPost.objects.get(id=consultation_post_id)
        form.instance.lawyer = lawyer
        form.instance.client = client
        return super().form_valid(form)
    
    def get_success_url(self):
        messages.success(self.request, "Requested Successfully...!!")
        return reverse("client:lawyerlist")
    


def make_payment(request, invoice_id):
    # Here, integrate your payment processing logic
    invoice = Invoice.objects.get(id=invoice_id)
    # For demonstration, let's assume the payment was successful
    invoice.status = 'paid'
    invoice.save()

    messages.success(request, "Payment successful for Invoice #{}".format(invoice_id))
    return redirect('client:client_dashboard')

class ClientDashboardView(LoginRequiredMixin, TemplateView):
    template_name = 'client/dashboard.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        # Ensure that the current user is a client
        if hasattr(self.request.user, 'client'):
            client = self.request.user.client

            # Fetch rooms, lawyer, invoices, and cases for the client
            context['rooms'] = Room.objects.filter(client=client)
            accepted_client = AcceptedClient.objects.filter(client=client).first()
            context['accepted_lawyer'] = accepted_client.lawyer if accepted_client else None
            context['invoices'] = Invoice.objects.filter(issued_to=client).order_by('-created_at')
            context['cases'] = Case.objects.filter(client=client).order_by('-created_at')
        else:
            context['rooms'] = []
            context['accepted_lawyer'] = None
            context['invoices'] = []
            context['cases'] = []

        return context


@login_required
def lawyer_profile_view(request):
    # Assuming the request.user is a Client and has an AcceptedClient relationship
    accepted_client = get_object_or_404(AcceptedClient, client=request.user.client)
    
    # Get the associated lawyer from the AcceptedClient record
    lawyer = accepted_client.lawyer
    
    # Get the consultation post for the associated lawyer
    consultation_post = get_object_or_404(ConsultationPost, lawyer=lawyer)
            
    context = {
        'lawyer': lawyer,
        'consultation_post': consultation_post,
    }
    
    return render(request, 'client/lawyer_profile_view.html', context)

class ClientRoomsView(LoginRequiredMixin, ListView):
    model = Room
    template_name = 'client/dashboard.html'
    context_object_name = 'rooms'
    
    def get_queryset(self):
        # Filter rooms based on the current user's role
        if hasattr(self.request.user, 'client'):
            return Room.objects.filter(client=self.request.user.client)
        else:
            # If the user is not a client, return an empty queryset
            return Room.objects.none()

    
class ChatRoomView(TemplateView):
    template_name = 'client/chat_room.html'
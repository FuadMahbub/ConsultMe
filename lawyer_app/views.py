from django.http import Http404, HttpResponseBadRequest, HttpResponseForbidden, HttpResponseRedirect
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.mixins import LoginRequiredMixin
from .models import *
from django.utils import timezone
from django.views.generic.edit import FormView
from .forms import *
from django.views.generic import *
from django.contrib.auth.decorators import login_required
from django.urls import reverse_lazy
from django.contrib import messages
from django.views.generic import *
from client_app.models import ConsultationRequest
from django.urls import reverse
from billing_app.models import Invoice
from case_app.models import *
from django.utils.decorators import method_decorator



# Create your views here.
@login_required
def lawyer_dashboard(request, invoice_id=None):
    consultation_posts = ConsultationPost.objects.filter(lawyer=request.user.lawyer)
    accepted_clients = AcceptedClient.objects.filter(lawyer=request.user.lawyer)
    rooms = Room.objects.filter(lawyer=request.user.lawyer)
    invoices = Invoice.objects.filter(issued_by=request.user.lawyer).order_by('-created_at')
    cases = Case.objects.filter(lawyer=request.user.lawyer).order_by('-created_at')  # Fetch cases for the lawyer


    invoice_detail = None
    if invoice_id:
        invoice_detail = Invoice.objects.filter(id=invoice_id, issued_by=request.user.lawyer).first()

    return render(request, 'lawyer/dashboard.html', {
        'consultation_posts': consultation_posts,
        'accepted_clients': accepted_clients,
        'rooms': rooms,
        'invoices': invoices,
        'cases': cases,  # Add cases to context
        'invoice_detail': invoice_detail,
    })
    
class LawyerClosedCasesView(LoginRequiredMixin, ListView):
    model = ClosedCase
    template_name = 'lawyer/closed_cases_list.html'

    def get_queryset(self):
        return ClosedCase.objects.filter(lawyer=self.request.user.lawyer)
    
    
class ClosedCaseListView(LoginRequiredMixin, ListView):
    model = ClosedCase
    template_name = 'lawyer/closed_cases_list.html'
    context_object_name = 'closed_cases'

    def get_queryset(self):
        return ClosedCase.objects.filter(lawyer=self.request.user.lawyer).order_by('-closed_at')
    


@method_decorator(login_required, name='dispatch')
class ClosedCaseDetailView(DetailView):
    model = ClosedCase
    template_name = 'lawyer/closed_case_detail.html'
    context_object_name = 'closed_case'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        closed_case = self.object
        context['invoice'] = Invoice.objects.filter(case=closed_case.case).first()
        context['client'] = closed_case.client
        context['case'] = closed_case.case
        return context

#Room for chat
class RoomCreateView(LoginRequiredMixin, CreateView):
    model = Room
    fields = ['name']
    template_name = 'lawyer/create_room.html'

    def form_valid(self, form):
        # Get the accepted client for the current lawyer
        accepted_client = AcceptedClient.objects.filter(lawyer=self.request.user.lawyer).first()
        # Check if the lawyer has already created a room for this accepted client
        existing_room = Room.objects.filter(lawyer=self.request.user.lawyer, client=accepted_client.client).exists()
        if existing_room:
            messages.error(self.request, "You can only create one room for one accepted client.")
            return redirect('lawyer:lawyerdashboard')
        # Set the client and lawyer for the room
        form.instance.client = accepted_client.client
        form.instance.lawyer = self.request.user.lawyer
        return super().form_valid(form)
    
    def get_success_url(self):
        messages.success(self.request, "Room Created Successfully...!!")
        return reverse("lawyer:lawyerdashboard")
    
class RoomDeleteView(LoginRequiredMixin,DeleteView):
    model = Room
    template_name = "lawyer/delete.html"
    
    
    def get_success_url(self):
        messages.success(self.request, "Data Deleted Successfully...!!")
        return reverse('lawyer:lawyerdashboard')
    
class RoomsView(LoginRequiredMixin, ListView):
    model = Room
    template_name = 'lawyer/dashboard.html'
    context_object_name = 'rooms'
    
    def get_queryset(self):
        # Filter rooms based on the current user's role
        if hasattr(self.request.user, 'lawyer'):
            return Room.objects.filter(lawyer=self.request.user.lawyer)
        elif hasattr(self.request.user, 'client'):
            return Room.objects.filter(client=self.request.user.client)
        else:
            return Room.objects.none()  # Return an empty queryset if user has no role



#Consultancy Request related views
class LawyerConsultationRequestsListView(LoginRequiredMixin, ListView):
    model = ConsultationRequest
    template_name = 'lawyer/request_list.html'
    context_object_name = 'consultation_requests'

    def get_queryset(self):
        lawyer = self.request.user.lawyer
        queryset = ConsultationRequest.objects.filter(lawyer=lawyer)
        consultation_post_id = self.kwargs.get('consultation_post_id')
        if consultation_post_id:
            queryset = queryset.filter(consultation_post_id=consultation_post_id)
        return queryset
    
class AcceptConsultationRequestView(LoginRequiredMixin, View):
    def post(self, request, *args, **kwargs):
        lawyer = request.user.lawyer
        # Check if the lawyer has already accepted a request
        if AcceptedClient.objects.filter(lawyer=lawyer).exists():
            messages.error(request, 'You have already accepted a request. You cannot accept another request.')
            return HttpResponseRedirect(reverse('lawyer:requestlist'))
        
        consultation_request_id = kwargs.get('pk')
        consultation_request = ConsultationRequest.objects.get(id=consultation_request_id)
        consultation_request.status = 'accepted'
        consultation_request.is_accepted = True
        consultation_request.save()
        
        
        accepted_client = AcceptedClient.objects.create(lawyer=lawyer, client=consultation_request.client)
        
        

        
        
        consultation_request.delete()
        messages.success(request, 'Request accepted successfully.')
        return HttpResponseRedirect(reverse('lawyer:requestlist'))
    
    

    
    
class RejectConsultationRequestView(LoginRequiredMixin, View):
    def post(self, request, *args, **kwargs):
        consultation_request_id = kwargs.get('pk')
        consultation_request = ConsultationRequest.objects.get(id=consultation_request_id)
        consultation_request.status = 'rejected'
        consultation_request.save()
        consultation_request.delete()
        messages.success(request, 'Request rejected successfully.')
        return HttpResponseRedirect(reverse('lawyer:requestlist'))
    
class AcceptedRequestsListView(LoginRequiredMixin, ListView):
    model = AcceptedClient
    template_name = 'lawyer/dashboard.html'  # Adjust template name as needed
    context_object_name = 'accepted_clients'

    def get_queryset(self):
        # Retrieve accepted clients associated with the logged-in lawyer
        lawyer = self.request.user.lawyer
        return AcceptedClient.objects.filter(lawyer=lawyer)
    
    
class AcceptedRequestDeleteView(LoginRequiredMixin, DeleteView):
    model = AcceptedClient
    template_name = "lawyer/delete.html"

    def delete(self, request, *args, **kwargs):
        # Fetch the object to be deleted
        self.object = self.get_object()

        

        # Proceed with the deletion of the AcceptedClient object
        response = super().delete(request, *args, **kwargs)  # This calls the delete method of the superclass

        # Optionally, add a success message
        messages.success(request, "Accepted request and related invoices deleted successfully.")

        return response

    def get_success_url(self):
        return reverse_lazy('lawyer:lawyerdashboard')



class ConsultationPostCreateView(CreateView):
    model = ConsultationPost
    form_class = ConsultationPostForm
    template_name = "lawyer/new_post.html"

    
    def form_valid(self, form):
        # Get the currently logged-in lawyer
        logged_in_lawyer = self.request.user.lawyer
        # Check if a consultation post already exists for the logged-in lawyer
        if ConsultationPost.objects.filter(lawyer=logged_in_lawyer).exists():
            # Display an error message
            messages.error(self.request, "You have already created a consultation post.")
            return self.form_invalid(form)
        form.instance.lawyer = logged_in_lawyer
        return super().form_valid(form)
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["title"] = "Create"
        context["heading"] = "Create New Consultancy Post"
        return context

    def get_success_url(self):
        messages.success(self.request, "Consultancy Post Created Successfully...!!")
        return reverse("lawyer:lawyerdashboard")


class LawyerConsultancyUpdateView(UpdateView):
    model = ConsultationPost
    template_name = "lawyer/new_post.html"
    form_class = ConsultationPostForm

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["title"] = "Edit"
        context["heading"] = "Update Consultancy Post"
        return context

    def get_success_url(self):
        messages.success(self.request, "Data Updated Successfully...!!")
        return reverse("lawyer:lawyerdashboard")


class LawyerConsultancyDeleteView(DeleteView):
    model = ConsultationPost
    template_name = "lawyer/delete.html"
    
    
    def get_success_url(self):
        messages.success(self.request, "Data Deleted Successfully...!!")
        return reverse('lawyer:lawyerdashboard')


class ConsultationPostListView(LoginRequiredMixin, ListView):
    model = ConsultationPost
    template_name = "lawyer/dashboard.html"
    context_object_name = "consultation_posts"

    def get_queryset(self):
        # Get the currently logged-in lawyer
        logged_in_lawyer = self.request.user.lawyer
        # Filter consultation posts belonging to the logged-in lawyer
        queryset = super().get_queryset().filter(lawyer=logged_in_lawyer)
        return queryset
    
    def form_valid(self, form):
        # Get the currently logged-in lawyer
        logged_in_lawyer = self.request.user.lawyer
        # Check if a consultation post already exists for the logged-in lawyer
        if ConsultationPost.objects.filter(lawyer=logged_in_lawyer).exists():
            # Display an error message
            messages.error(self.request, "You have already created a consultation post.")
            return self.form_invalid(form)
        form.instance.lawyer = logged_in_lawyer
        return super().form_valid(form)


@login_required
def consultation_requests_list_view(request):

    # Ensure the logged-in user is a lawyer
    try:
        lawyer = Lawyer.objects.get(user=request.user)
    except Lawyer.DoesNotExist:
        # Redirect or handle as you see fit if the user is not a lawyer
        return render(request, "errors/not_a_lawyer.html")

    # Fetch all consultation requests or filter based on the logged-in user's role or ID
    # consultation_requests = (
    #     # ClientConsultationRequest.objects.filter(consultation__lawyer=lawyer)
    #     .select_related("client")
    #     .all()
    # )

    return render(
        # request, "lawyer/request_list.html", {"object_list": consultation_requests}
    )

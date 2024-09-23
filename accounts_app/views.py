from django.http import HttpResponseRedirect
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.views.generic import *
from .models import *
from .forms import *
from django.urls import reverse_lazy
from django.contrib import messages
from django.contrib.auth import authenticate, login
from django.views.generic.edit import FormView
from django.contrib.auth.views import LoginView, LogoutView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views import View


# Create your views here.


# ---------Choosing User---------------
def choose_user_view(request):
    return render(request, "accounts/choose.html")


def choose_login_view(request):
    return render(request, "accounts/login_choose.html")


class SignUpView(FormView):
    template_name = "accounts/signup.html"
    form_class = CustomUserCreationForm

    def form_valid(self, form):
        form.save()
        return HttpResponseRedirect("accounts/registration_success.html")


# ----------SIGNUP VIEW---------------
class ClientSignUpView(FormView):
    template_name = "accounts/client_registration.html"
    form_class = ClientRegistrationForm

    def form_valid(self, form):
        # Check if the client already exists
        if self.client_exists(form.cleaned_data['email']):
            messages.error(self.request, "A client with this email already exists.")
            return self.form_invalid(form)  # Redirect back to the registration form with validation errors

        # If the client does not exist, save the form and redirect
        form.save()
        messages.success(self.request, "You have successfully a Client registered.")
        return redirect(reverse("accounts:clientlogin"))

    def client_exists(self, email):
        # Implement a check to see if a client with the given email already exists in your system
        # Assuming Client is your model and email is a field on your model
        return Client.objects.filter(email=email).exists()


class LawyerSignUpView(FormView):
    template_name = "accounts/lawyer_registration.html"
    form_class = LawyerRegistrationForm

    def form_valid(self, form):
        # Check if the lawyer already exists
        if self.lawyer_exists(form.cleaned_data['email']):
            messages.error(self.request, "A lawyer with this email already exists.")
            return self.form_invalid(form)  # Redirect back to the registration form with validation errors

        # If the lawyer does not exist, save the form and redirect
        form.save()
        messages.success(self.request, "You have successfully registered as a Lawyer.")
        return redirect(reverse("accounts:lawyerlogin"))

    def lawyer_exists(self, email):
        # Implement a check to see if a lawyer with the given email already exists in your system
        # Assuming Lawyer is your model and email is a field on your model
        return Lawyer.objects.filter(email=email).exists()


# -----------HOME VIEW-----------


def lawyer_home_view(request):
    return render(request, "lawyer/lawyer_home.html")


def client_home_view(request):
    return render(request, "client/client_home.html")


# -------------LOGIN VIEW--------------
class LawyerLoginView(View):
    def get(self, request):
        form = LawyerLoginForm()
        return render(request, "accounts/lawyer_login.html", {"form": form})

    def post(self, request):
        form = LawyerLoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data["email"]
            password = form.cleaned_data["password"]
            user = authenticate(request, email=email, password=password)
            if user and user.is_active and hasattr(user, "lawyer"):
                login(request, user)
                
                return redirect("accounts:lawyer_home")
            
            else:
                messages.error(request, "Invalid credentials or you are not a lawyer!")  # Pop-up error message
        return render(request, "accounts/lawyer_login.html", {"form": form})


class ClientLoginView(View):
    def get(self, request):
        form = ClientLoginForm()
        return render(request, "accounts/client_login.html", {"form": form})

    def post(self, request):
        form = ClientLoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data["email"]
            password = form.cleaned_data["password"]
            user = authenticate(request, email=email, password=password)
            if user and user.is_active and hasattr(user, "client"):
                login(request, user)
                messages.success(request, "You have been logged in as a Client Successfully!")
                return redirect("accounts:client_home")  
            else:
                messages.error(request, "Invalid credentials or not a client.")  # Show error message
        return render(request, "accounts/client_login.html", {"form": form})


class LogoutViewUser(LogoutView):
    success_url = reverse_lazy("home")


class LawyerProfileView(LoginRequiredMixin, TemplateView):
    template_name = "lawyer/lawyer_profile.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["lawyer"] = get_object_or_404(Lawyer, user=self.request.user)
        return context


# Client Profile
class ClientProfileView(LoginRequiredMixin, TemplateView):
    template_name = "client/client_profile.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["client"] = get_object_or_404(Client, user=self.request.user)
        return context


class UpdateLawyerProfileView(LoginRequiredMixin, UpdateView):
    model = Lawyer
    form_class = LawyerProfileForm
    template_name = "lawyer/lawyer_update.html"
    success_url = reverse_lazy("accounts:lawyer_profile")

    def get_object(self, queryset=None):
        # Ensures that only the lawyer associated with the current user is updated
        return self.request.user.lawyer
    
    def form_valid(self, form):
        # Check if the uploaded file is an image
        photo_file = form.cleaned_data.get('photo')  # Adjust 'photo' according to your field name in the form
        if photo_file:
            if not photo_file.name.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):
                # Not an image file
                messages.error(self.request, "Only image files are allowed.")
                return self.form_invalid(form)
        
        # If it's an image file, proceed as usual
        response = super().form_valid(form)
        messages.success(self.request, "Your profile has been successfully updated.")
        return response
    
    

class UpdateClientProfileView(LoginRequiredMixin, UpdateView):
    model = Client
    form_class = ClientProfileForm
    template_name = "client/client_update.html"
    success_url = reverse_lazy("accounts:client_profile")

    def get_object(self, queryset=None):
        # Ensures that only the client associated with the current user is updated
        return self.request.user.client

    def form_valid(self, form):
        # Check if the uploaded file is an image
        photo_file = form.cleaned_data.get('photo')  # Adjust 'photo' according to your field name in the form
        if photo_file:
            if not photo_file.name.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):
                # Not an image file
                messages.error(self.request, "Only image files are allowed.")
                return self.form_invalid(form)

        # If it's an image file, proceed as usual
        response = super().form_valid(form)
        messages.success(self.request, "Your profile has been successfully updated.")
        return response


def lawyer_list(request, expertise_slug=None):
    expertise = None
    expertise = Expertise.objects.all()
    lawyers = Lawyer.objects.all()
    if expertise_slug:
        expertise = get_object_or_404(Expertise, slug=expertise_slug)
        lawyers = Lawyer.objects.filter(expertise=expertise)

    context = {"expertise": expertise, "expertise": expertise, "object_list": lawyers}
    return render(request, "lawyer/categories.html", context)


def collegelist(request, colleges_slug=None):
    colleges = None
    colleges = Colleges.objects.all()
    lawyers = Lawyer.objects.all()
    if colleges_slug:
        colleges = get_object_or_404(Colleges, slug=colleges_slug)
        lawyers = Lawyer.objects.filter(colleges=colleges)

    context = {"colleges": colleges, "colleges": colleges, "object_list": lawyers}
    return render(request, "lawyer/colleges.html", context)




from django.contrib.auth.forms import (
    UserCreationForm,
    UserChangeForm,
)
from .models import *
from django import forms
from django.contrib.auth.hashers import make_password
from django.contrib.auth import authenticate

from django.core.exceptions import ValidationError


class CustomUserCreationForm(UserCreationForm):
    class Meta(UserCreationForm.Meta):
        model = CustomUser
        fields = ("email",)

    def save(self, commit=True):
        user = super().save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user


class UserChangingform(UserChangeForm):
    class Meta:
        model = CustomUser
        fields = ("email",)


class LawyerLoginForm(forms.Form):
    email = forms.EmailField(label="Email")
    password = forms.CharField(label="Password", widget=forms.PasswordInput)

    error_messages = {
        "invalid_login": (
            "Please enter a correct email and password. Note that both "
            "fields may be case-sensitive."
            "Invalid credentials or not a lawyer"
        ),
        "inactive": ("This account is inactive."),
    }


class ClientLoginForm(forms.Form):
    email = forms.EmailField(label="Email")
    password = forms.CharField(label="Password", widget=forms.PasswordInput)

    error_messages = {
        "invalid_login": (
            "Please enter a correct email and password. Note that both "
            "fields may be case-sensitive."
            "Invalid credentials or not a client"
        ),
        "inactive": ("This account is inactive."),
    }


class ClientRegistrationForm(forms.ModelForm):
    email = forms.EmailField(label="Email")
    username = forms.CharField(label="Username")
    password1 = forms.CharField(label="Password", widget=forms.PasswordInput)
    password2 = forms.CharField(
        label="Password confirmation", widget=forms.PasswordInput
    )

    error_messages = {
        "invalid_login": (
            "Please enter a correct email and password. Note that both "
            "fields may be case-sensitive."
        ),
        "inactive": ("This account is inactive."),
    }

    class Meta:
        model = Client
        fields = ("email", "username", "phone_number", "address")

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # self.fields['email'].label = "Email"
        self.fields["phone_number"].label = "Phone Number"

    def clean_email(self):
        email = self.cleaned_data.get("email")
        if Client.objects.filter(email=email).exists():
            raise forms.ValidationError("This email is already in use.")
        return email

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords don't match")
        return password2

    def save(self, commit=True):
        client = super().save(commit=False)
        user = CustomUser(email=self.cleaned_data["email"])
        user.set_password(self.cleaned_data["password1"])
        user.save()
        client.email = self.cleaned_data["email"]
        client.user = user
        if commit:
            client.save()
        return client


class LawyerRegistrationForm(forms.ModelForm):
    email = forms.EmailField(label="Email")
    username = forms.CharField(label="Username")
    password1 = forms.CharField(label="Password", widget=forms.PasswordInput)
    password2 = forms.CharField(
        label="Password confirmation", widget=forms.PasswordInput
    )

    error_messages = {
        "invalid_login": (
            "Please enter a correct email and password. Note that both "
            "fields may be case-sensitive."
        ),
        "inactive": ("This account is inactive."),
    }

    class Meta:
        model = Lawyer
        fields = ("email", "username", "phone_number", "address", "expertise","college")

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # self.fields['email'].label = "Email"
        self.fields["phone_number"].label = "Phone Number"

    def clean_email(self):
        email = self.cleaned_data.get("email")
        if Lawyer.objects.filter(email=email).exists():
            raise forms.ValidationError("This email is already in use.")
        return email

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords don't match")
        return password2

    def save(self, commit=True):
        client = super().save(commit=False)
        user = CustomUser(email=self.cleaned_data["email"])
        user.set_password(self.cleaned_data["password1"])
        user.save()
        client.email = self.cleaned_data["email"]
        client.user = user
        if commit:
            client.save()
        return client


# Profile Form
class ClientProfileForm(forms.ModelForm):
    class Meta:
        model = Client
        fields = ("email", "username", "phone_number", "address", "photo")


class LawyerProfileForm(forms.ModelForm):
    class Meta:
        model = Lawyer
        fields = ("email", "username", "phone_number", "address", "college", "expertise","photo")

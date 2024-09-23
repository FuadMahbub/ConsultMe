from django.db import models

from django.contrib.auth.models import AbstractBaseUser, AbstractUser, BaseUserManager
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils import timezone
from django.utils.text import slugify
from django.urls import reverse

from django.utils.translation import gettext_lazy as gtl
from django.contrib.auth.models import PermissionsMixin


# from core_app.models import Contact

# Create your models here.


class UserManager(BaseUserManager):
    """
    Custom User model manager where email is the unique identifiers
    for authentication instead of username
    """

    def create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError("Email field is required")
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password, **extra_fields):
        """
        Create and save a Superuser with the giver email and password
        """

        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_active", True)
        extra_fields.setdefault("is_superuser", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError(gtl("Superuser must have is_staff=True."))

        if extra_fields.get("is_superuser") is not True:
            raise ValueError(gtl("Superuser must have is_superuser=True."))
        return self.create_user(email, password, **extra_fields)


class CustomUser(AbstractBaseUser, PermissionsMixin):

    email = models.EmailField(gtl("email address main"), unique=True)
    username = models.CharField(gtl("Username"), max_length=55, blank=True)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    date_joined = models.DateTimeField(default=timezone.now)

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []

    objects = UserManager()

    def __str__(self):
        return self.email

    # if not the code below then taking default value in User Model Not in proxy Model


class Expertise(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField("Expertise Type", max_length=100)
    slug = models.SlugField(max_length=150, unique=True, db_index=True, blank=True)

    def __str__(self):
        return f"{self.name}"

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        return super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse("accounts:lawyerlist_by_expertise", args=[self.slug])

class Colleges(models.Model):
    id      = models.AutoField(primary_key=True)
    name    = models.CharField("Colleges", max_length=100)
    slug    = models.SlugField(max_length=150, unique=True, db_index=True, blank=True)

    def __str__(self):
        return f"{self.name}"

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        return super().save(*args, **kwargs)
    
    def get_absolute_url(self):
        return reverse("accounts:collegelist", args=[self.slug])

class Lawyer(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    email = models.EmailField(gtl("email address main"), unique=True, default="")
    username = models.CharField(max_length=150, unique=True, null=True, blank=True)
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    address = models.TextField(max_length=550, null=True, blank=True)
    expertise = models.ForeignKey(Expertise, on_delete=models.CASCADE)
    college = models.ForeignKey(Colleges, on_delete=models.CASCADE)
    
    photo = models.FileField(
        upload_to="myimage", default="myimage/blank.png", blank=True
    )
    created_at = models.DateTimeField(default=timezone.now)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.user.email
    
    def total_clients_served(self):
        return self.accepted_clients.count()

    def total_payments_received(self):
        return sum(invoice.amount for invoice in self.issued_invoices.all() if invoice.status == 'paid')

    def client_details(self):
        return [(client.client.user.email, client.client.user.phone_number) for client in self.accepted_clients.all()]


class Client(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    email = models.EmailField(gtl("email address main"), unique=True, default="")
    username = models.CharField(max_length=150, unique=True, null=True, blank=True)
    phone_number = models.CharField(max_length=20, null=True, blank=True)
    address = models.TextField(max_length=550, null=True, blank=True)
    photo = models.FileField(
        upload_to="myimage", default="myimage/blank.png", blank=True
    )
    created_at = models.DateTimeField(default=timezone.now)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.user.email



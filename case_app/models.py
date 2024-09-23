from django.db import models
from accounts_app.models import Lawyer, Client,CustomUser
from django.utils import timezone
from django.core.validators import MinValueValidator, MaxValueValidator
from lawyer_app.models import ConsultationPost
# Create your models here.

class Case(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE, related_name='cases')
    lawyer = models.ForeignKey(Lawyer, on_delete=models.CASCADE, related_name='cases')
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    start_date = models.DateField(default=timezone.now)
    end_date = models.DateField()
    pay_in_advance = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    due = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    total = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Case {self.id} - Lawyer: {self.lawyer.email}, Client: {self.client.email}"


class CaseFile(models.Model):
    case = models.ForeignKey(Case, on_delete=models.CASCADE, related_name='files')
    file = models.FileField(upload_to='case_files/')
    description = models.TextField()
    uploaded_at = models.DateTimeField(auto_now_add=True)
    uploaded_by = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name='uploaded_files')

    def __str__(self):
        return f"File for Case {self.case.id}"

class ClosedCase(models.Model):
    case = models.OneToOneField(Case, on_delete=models.CASCADE, related_name='closed_case')
    lawyer = models.ForeignKey(Lawyer, on_delete=models.CASCADE, related_name='closed_cases')
    client = models.ForeignKey(Client, on_delete=models.CASCADE, related_name='closed_cases')
    closed_at = models.DateTimeField(default=timezone.now)
    rating = models.IntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(5)], blank=True, null=True  # 1 to 5 stars
    )
    review = models.TextField(blank=True, null=True)  # Client review
    feedback = models.TextField(blank=True, null=True)  # Any additional feedback

    def __str__(self):
        return f"Closed Case {self.case.id} - Lawyer: {self.lawyer.user.email}, Client: {self.client.user.email}"



   
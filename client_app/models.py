from django.db import models
from lawyer_app.models import *
from accounts_app.models import *

# Create your models here.

class ConsultationRequest(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE,related_name='consultation_requests')
    lawyer = models.ForeignKey(Lawyer, on_delete=models.CASCADE)
    consultation_post = models.ForeignKey(ConsultationPost, on_delete=models.CASCADE)
    problem = models.TextField()
    document = models.FileField(upload_to='documents/', null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=20, choices=[('pending', 'Pending'), ('accepted', 'Accepted'), ('rejected', 'Rejected')], default='pending')
    is_accepted = models.BooleanField(default=False)
    class Meta:
        unique_together = ('client', 'lawyer')

    def __str__(self):
        return f"Consultation Request from {self.client.email} to {self.lawyer.user.email}"




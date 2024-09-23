from django.db import models
from accounts_app.models import Lawyer, Client, Colleges, Expertise
from django.utils import timezone
# Create your models here.

class ConsultationPost(models.Model):
    lawyer  = models.OneToOneField(Lawyer, on_delete=models.CASCADE)
    years_of_experience = models.PositiveIntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    consultation_fee = models.DecimalField(max_digits=10, decimal_places=2)
    available_from = models.TimeField()
    available_to = models.TimeField()
    is_available = models.BooleanField(default=True)
    
    def __str__(self):
        return f"Consult Post by {self.lawyer.email}"
    
    



class AcceptedClient(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    lawyer = models.ForeignKey(Lawyer, related_name='accepted_clients', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    
class Room(models.Model):
    name = models.CharField(max_length=100)
    client = models.ForeignKey(Client, on_delete=models.CASCADE)    
    lawyer = models.ForeignKey(Lawyer, related_name='rooms', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)






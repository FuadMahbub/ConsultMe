from django.db import models
from accounts_app.models import Client, Lawyer,CustomUser
from lawyer_app.models import Room
# Create your models here.


class Message(models.Model):
    room = models.ForeignKey(Room, related_name='messages', on_delete=models.CASCADE)
    sender = models.ForeignKey(CustomUser, related_name='messages', on_delete=models.CASCADE)
    content = models.TextField()
    
    timestamp  = models.DateTimeField(auto_now_add=True) 

    class Meta:
        ordering =('timestamp',)
    
    

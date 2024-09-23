from django.db import models
from accounts_app.models import Lawyer
# Create your models here.
class Chat(models.Model):
    user = models.ForeignKey(Lawyer, on_delete=models.CASCADE)
    message = models.TextField()
    response = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.user.email}: {self.message}'
    
    
class LawExplainer(models.Model):
    _input= models.TextField()
    _output= models.TextField()
    
    class Meta:
        db_table="t_law_explainer"
from django.db import models
from accounts_app.models import *
from case_app.models import *
# Create your models here.

class Invoice(models.Model):
    issued_to = models.ForeignKey(Client, on_delete=models.CASCADE, related_name='invoices')
    issued_by = models.ForeignKey(Lawyer, on_delete=models.CASCADE, related_name='issued_invoices')
    case = models.ForeignKey(Case, on_delete=models.CASCADE, related_name='invoices', null=True, blank=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    description = models.TextField()
    status = models.CharField(max_length=100, default='unpaid')  # e.g., unpaid, paid, cancelled
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    payment_reference = models.CharField(max_length=100, blank=True, null=True)  # Payment reference ID
    card_last_four = models.CharField(max_length=4, blank=True, null=True)  # Last four digits of the card

    def __str__(self):
        return f"Invoice {self.id} for {self.issued_to} - {self.status}"

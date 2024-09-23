from django import forms
from .models import Invoice
from django.forms.widgets import DateInput
from datetime import date

class PaymentForm(forms.Form):
    
    card_number = forms.CharField(label="Card Number", help_text="1234-1234-1234-1234", max_length=16, widget=forms.PasswordInput)  # Masked input
    expiration_date = forms.DateField(
        label="Expiration Date",
        input_formats=['%Y-%m-%d'],  # Expected format for date input
        widget=DateInput(
            attrs={
                "type": "date",
                "min": date.today().isoformat(),  # Sets the minimum date to today
            }
        )
    )
    cvv = forms.CharField(label="CVV--Max Length 3", max_length=3, widget=forms.PasswordInput)
    amount = forms.DecimalField(max_digits=10, decimal_places=2, help_text="Enter the amount you wish to pay.")
    cardholder_name = forms.CharField(label="Cardholder Name", max_length=100)
    
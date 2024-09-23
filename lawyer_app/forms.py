from accounts_app.models import *
from accounts_app.forms import *
from .models import *
from django import forms


class ConsultationPostForm(forms.ModelForm):
    class Meta:
        model = ConsultationPost
        fields = [
            
            'years_of_experience',
            'consultation_fee',
            'available_from',
            'available_to',
            'is_available',
        ]
        widgets = {
           
            "available_from": forms.TimeInput(attrs={"type": "time"}),
            "available_to": forms.TimeInput(attrs={"type": "time"}),
            
        }

    def clean(self):
        cleaned_data = super().clean()
        available_from = cleaned_data.get('available_from')
        available_to = cleaned_data.get('available_to')

        if available_from and available_to and available_from >= available_to:
            raise forms.ValidationError("Available from time must be before available to time.")

        return cleaned_data
        

class RoomCreationForm(forms.ModelForm):
    class Meta:
        model = Room
        fields = ['name']


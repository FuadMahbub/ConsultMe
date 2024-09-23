from django import forms
from .models import *
from django.forms import  HiddenInput

class ConsultationRequestForm(forms.ModelForm):
    class Meta:
        model = ConsultationRequest
        fields = ['lawyer','consultation_post', 'problem', 'document']
        widgets = {
            'lawyer': HiddenInput(),
            'consultation_post': HiddenInput(),
            
            'document': forms.FileInput(attrs={'class': 'form-control'}),
        }
        
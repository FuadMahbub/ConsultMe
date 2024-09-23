from django import forms
from .models import CaseFile,ClosedCase,Case

class FileUploadForm(forms.ModelForm):
    class Meta:
        model = CaseFile
        fields = ['file', 'description']

class ClosedCaseRatingForm(forms.ModelForm):
    class Meta:
        model = ClosedCase
        fields = ['rating', 'review','feedback']


class CaseCreationForm(forms.ModelForm):
    class Meta:
        model = Case
        fields = ['name', 'description', 'start_date', 'end_date']
        widgets = {
            'start_date': forms.DateInput(attrs={'type': 'date', 'class': 'form-control'}),
            'end_date': forms.DateInput(attrs={'type': 'date', 'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'description': forms.Textarea(attrs={'class': 'form-control'}),
        }

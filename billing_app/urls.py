from django.urls import path
from . import views
from .views import *

urlpatterns = [
    path("invoice/create/",views.InvoiceCreateView.as_view(),name='invoice_create'),
    
    path('invoice/client/<int:pk>/', views.ClientInvoiceDetailView.as_view(), name='clientinvoice_detail'),
    path('invoice/lawyer/<int:pk>/', views.LawyerInvoiceDetailView.as_view(), name='lawyer_invoice_detail'),
    path('invoices/download/<int:invoice_id>/', download_invoice, name='download_invoice'),
    
    

    path('process_payment/<int:case_id>/', views.ProcessPaymentView.as_view(), name='process_payment'),
]

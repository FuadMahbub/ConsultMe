from django.urls import path
from case_app import views
from .views import *

urlpatterns = [
    path('cases/', views.CaseListView.as_view(), name='case_list'),
    # path('cases/<int:pk>/', views.CaseDetailView.as_view(), name='case_detail'),
    path('case/<int:case_id>/upload_file_lawyer/', views.LawyerFileUploadView.as_view(), name='lawyer_upload_file'),

    path('case/<int:case_id>/upload_file_client/', views.ClientFileUploadView.as_view(), name='client_upload_file'),

    path('lawyer_cases/<int:pk>/', views.LawyerCaseDetailView.as_view(), name='lawyer_case'),

    path('client_cases/<int:pk>/', views.ClientCaseDetailView.as_view(), name='client_case_detail'),

    path('case/<int:case_id>/download_received_files/', views.DownloadReceivedFilesView.as_view(), name='download_received_files'),

    path('case/close/<int:case_id>/', views.close_case, name='close_case'),

     # Closed case rating view
    path('closed_case/<int:pk>/rate/', views.ClosedCaseRatingView.as_view(), name='rate_closed_case'),

    #Create Case

    path('case/new/', views.CaseCreateView.as_view(), name='create_case'),

    path('case/delete/<int:pk>/', views.CaseDeleteView.as_view(), name='case_delete'),
]

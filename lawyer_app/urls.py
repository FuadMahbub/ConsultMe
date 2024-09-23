from django.urls import path, include
from lawyer_app.views import *
from lawyer_app import views


urlpatterns = [
    path(
        "dashboard/", lawyer_dashboard, name="lawyerdashboard"
    ),
    path(
        "lawyer/new_post/", views.ConsultationPostCreateView.as_view(), name="new_post"
    ),
    
    path('lawyer/dashboard/invoice/<int:invoice_id>/', lawyer_dashboard, kwargs={'invoice_id': None}, name='lawyer_dashboard_invoice'),
    
    path(
        "lawyer/update_post/<int:pk>",
        views.LawyerConsultancyUpdateView.as_view(),
        name="update",
    ),
    path(
        "lawyer/delete_post/<int:pk>",
        views.LawyerConsultancyDeleteView.as_view(),
        name="delete",
    ),
    path(
        "lawyer/client_requests/", views.LawyerConsultationRequestsListView.as_view(), name="requestlist"
    ),
    
    path('requests/', views.LawyerConsultationRequestsListView.as_view(), name='requestlist'),
    path('requests/<int:pk>/accept/', views.AcceptConsultationRequestView.as_view(), name='accept_request'),
    path('requests/<int:pk>/reject/', views.RejectConsultationRequestView.as_view(), name='reject_request'),
    
    path(
        "lawyer/delete_accepted_client/<int:pk>",
        views.AcceptedRequestDeleteView.as_view(),
        name="delete_client",
    ),
    # path('accepted-requests/', AcceptedRequestsListView.as_view(), name='lawyerdashboard'),
    
    #For Room
    path('room/create/', views.RoomCreateView.as_view(), name='room_create'),
    path('room/<int:pk>/',  views.RoomsView.as_view(), name='room_detail'),
    
    path(
        "lawyer/delete_room/<int:pk>",
        views.RoomDeleteView.as_view(),
        name="room_delete",
    ),


     # Lawyer's closed cases list
    path('lawyer/closed_cases/', views.ClosedCaseListView.as_view(), name='lawyer_closed_cases'),

    path('closed_case/<int:pk>/', views.ClosedCaseDetailView.as_view(), name='closed_case_detail'),


    
]

from django.urls import path, include
from django.views import View
from client_app.views import *
from client_app import views

urlpatterns = [
    # path('request-form/',views.consultation_requests_view,name="request"),
    path("request-form/<int:consultation_post_id>/", views.RequestForConsultationCreateView.as_view(), name="consult_request"),
    path('lawyerlist/',views.AvailableLawyersListView.as_view(),name='lawyerlist'),
    path('lawyer_profile_view/<int:pk>/',views.AvailableLawyerProfileView.as_view(),name='profile_view'),
    path('client/dashboard/', views.ClientDashboardView.as_view(), name='client_dashboard'),
    path('client/dashboard/invoice/<int:invoice_id>/', ClientDashboardView.as_view(), name='client-invoice-dashboard'),
    
    path('chat-room/', ChatRoomView.as_view(), name='chat_room'),
    
    path('make-payment/<int:invoice_id>/', make_payment, name='make-payment'),
    path('accepted_lawyer_profile/', lawyer_profile_view, name='lawyer_profile_view'),
    
     
     
]

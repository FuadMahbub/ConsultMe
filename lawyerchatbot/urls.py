from django.contrib import admin
from django.urls import path, include
from . import views

app_name = 'lawyerchatbot'

urlpatterns = [
    path('chat-api/', views.chatbot_response, name='chatbot_response'),
    path('chat/', views.chat, name='chat'),
    
]

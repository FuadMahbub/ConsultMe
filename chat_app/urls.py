from django.urls import path
from . import views

urlpatterns = [
    path('lawyer-chat-room/', views.LawyerChatRoomView.as_view(), name='lawyer_chat_room'),
    path('client-chat-room/', views.ClientChatRoomView.as_view(), name='client_chat_room'),
    # path('index/', views.index, name='index_chat_room'),
    #   path("<str:room_name>/", views.room, name="room"),
     
    path('room/<int:room_id>/', views.room, name='chatroom'),

]
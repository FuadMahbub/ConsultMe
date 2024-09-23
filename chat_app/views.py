from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.views.generic import TemplateView
from .models import Message
from django.shortcuts import get_object_or_404
from .forms import MessageForm
from lawyer_app.models import Room
# Create your views here.


class LawyerChatRoomView(TemplateView):
    template_name = 'chat/lawyer_chat_room.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        chat_room = get_object_or_404(Room, accepted_client__lawyer=self.request.user.lawyer)
        context['chat_room'] = chat_room
        context['form'] = MessageForm()
        return context

    def post(self, request, *args, **kwargs):
        form = MessageForm(request.POST)
        if form.is_valid():
            message = form.save(commit=False)
            message.room = get_object_or_404(Room, accepted_client__lawyer=self.request.user.lawyer)
            message.sender = self.request.user
            message.save()
            return redirect('chat:lawyer_chat_room')
        else:
            chat_room = get_object_or_404(Room, accepted_client__lawyer=self.request.user.lawyer)
            return render(request, 'chat/lawyer_chat_room.html', {'chat_room': chat_room, 'form': form})



class ClientChatRoomView(TemplateView):
    template_name = 'chat/client_chat_room.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        chat_room = get_object_or_404(Room, accepted_client__client=self.request.user.client)
        context['chat_room'] = chat_room
        context['form'] = MessageForm()
        return context

    def post(self, request, *args, **kwargs):
        form = MessageForm(request.POST)
        if form.is_valid():
            message = form.save(commit=False)
            message.room = get_object_or_404(Room, accepted_client__client=self.request.user.client)
            message.sender = self.request.user
            message.save()
            return redirect('client_chat_room')
        else:
            chat_room = get_object_or_404(Room, accepted_client__client=self.request.user.client)
            return render(request, 'chat/client_chat_room.html', {'chat_room': chat_room, 'form': form})
        
      
      
def room(request, room_id):
    room = get_object_or_404(Room, id=room_id)
    messages = Message.objects.filter(room=room)[:25]
    
    lawyer_email = room.lawyer.user.email
    client_email = room.client.user.email
    
    if request.user == room.lawyer.user or request.user == room.client.user:
        return render(request, "chat/room.html", {
            "room_name": room.name,
            "room_id": room_id,
            "lawyer_email": lawyer_email,
            "client_email": client_email,
            "messages": messages,
        })
    return redirect('some_error_page') 


# def index(request):
#     return render(request, "chat/index.html")

# def room(request, room_name):
#     return render(request, "chat/room.html", {"room_name": room_name})
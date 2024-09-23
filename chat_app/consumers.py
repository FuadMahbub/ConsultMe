import json
from channels.generic.websocket import AsyncWebsocketConsumer,WebsocketConsumer
from .models import Message
from asgiref.sync import async_to_sync
from channels.db import database_sync_to_async
from lawyer_app.models import Room
from accounts_app.models import CustomUser

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_id = self.scope["url_route"]["kwargs"]["room_id"]

        self.room = await self.get_room(self.room_id)
        if not self.room:
            await self.close()
        else:
            self.room_group_name = f'chat_{self.room_id}'

        # Join room group
        await self.channel_layer.group_add(self.room_group_name, self.channel_name)

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(self.room_group_name, self.channel_name)

    # Receive message from WebSocket
    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json["message"]
        sender_email = text_data_json['email']
        
    # Ensure the room and sender exist before saving the message
        if self.room and sender_email:
            sender = await self.get_sender(sender_email)
            await self.create_message(sender, message)
        
        # Send message to room group
        await self.channel_layer.group_send(
            self.room_group_name, {
                "type": "chat_message",
                "message": message,
                'email': sender_email,
        }
    )

    # Receive message from room group
    async def chat_message(self, event):
        message = event["message"]
        sender_email = event['email']
        
        # Send message to WebSocket
        await self.send(text_data=json.dumps({
            
            "message": message,
            'email': sender_email,
            
            
            }))
    
    @database_sync_to_async
    def get_room(self, room_id):
        try:
            room = Room.objects.get(id=room_id)
            # Check if the current user is the lawyer or the client of the room
            if self.scope["user"] == room.lawyer.user or self.scope["user"] == room.client.user:
                return room
        except Room.DoesNotExist:
            return None
    
    @database_sync_to_async
    def create_message(self, sender, message):
        return Message.objects.create(room=self.room, sender=sender, content=message)
    
    # Get sender asynchronously
    @database_sync_to_async
    def get_sender(self, sender_email): 
        return CustomUser.objects.get(email=sender_email)
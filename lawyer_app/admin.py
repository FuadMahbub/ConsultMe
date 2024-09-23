from django.contrib import admin
from lawyer_app.models import *

# Register your models here.


@admin.register(ConsultationPost)
class ConsultationPostAdmin(admin.ModelAdmin):
    list_display = ['lawyer', 'years_of_experience', 'created_at', 'is_available']
    list_filter = ['is_available']
    search_fields = ['lawyer__email']
    readonly_fields = ['created_at']

    fieldsets = (
        (None, {
            'fields': ('lawyer', 'created_at')
        }),
        ('Consultation Details', {
            'fields': ('years_of_experience', 'consultation_fee', 'available_from', 'available_to', 'is_available'),
        }),
    )

    def get_readonly_fields(self, request, obj=None):
        readonly_fields = super().get_readonly_fields(request, obj)
        if obj:
            return readonly_fields + ['lawyer']
        return readonly_fields




class AcceptedClientAdmin(admin.ModelAdmin):
    list_display = ('client', 'lawyer', 'created_at')
    search_fields = ('client__email', 'lawyer__user__email')
    list_filter = ('created_at',)

# class ChatRoomAdmin(admin.ModelAdmin):
#     list_display = ('room_name', 'client', 'lawyer')
#     search_fields = ('room_name', 'client__email', 'lawyer__user__email')
    
    
admin.site.register(AcceptedClient, AcceptedClientAdmin)
admin.site.register(Room)
# admin.site.register(ChatRoom, ChatRoomAdmin)


# class ClientConsultationRequestAdmin(admin.ModelAdmin):
#     list_display = ("id", "client", "consultation", "problem", "document", "status")


# class SelectedClientAdmin(admin.ModelAdmin):
#     list_display = ("id", "consultation", "client", "date_requested")


# admin.site.register(ConsultationPost, ConsultationPostAdmin)
# admin.site.register(ClientConsultationRequest, ClientConsultationRequestAdmin)
# admin.site.register(SelectedClient, SelectedClientAdmin)

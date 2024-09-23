from django.contrib import admin
from client_app.models import *

# Register your models here.


class ConsultationRequestAdmin(admin.ModelAdmin):
    list_display = ('client', 'lawyer','consultation_post', 'problem', 'created_at','document','status')
    list_filter = ('client', 'lawyer','consultation_post', 'created_at')
    search_fields = ('client__email', 'lawyer__user__email', 'problem')
    
admin.site.register(ConsultationRequest,ConsultationRequestAdmin)
    
# class MyConsultationRequestListAdmin(admin.ModelAdmin):
#     list_display = ("id", "client", "consultation", "date_applied")


# admin.site.register(MyConsultationRequestList, MyConsultationRequestListAdmin)


# class AcceptedConsultationListAdmin(admin.ModelAdmin):
#     list_display = ("id", "client", "consultation", "date_applied")


# admin.site.register(AcceptedConsultationList, AcceptedConsultationListAdmin)

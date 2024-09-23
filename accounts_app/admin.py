from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User


# from import_export import resources
# from import_export.admin import ImportExportMixin

from .models import *
from .forms import *

# Register your models here.

# class ClientResource(resources.ModelResource):
#     class Meta:
#         model=Client
#         exclude=('profile_picture','created_at','updated_at',)


class User_Admin(UserAdmin):
    add_form = CustomUserCreationForm
    form = UserChangingform
    model = CustomUser
    list_display = (
        "id",
        "email",
        "username",
        "is_staff",
        "is_active",
        "address",
    )
    list_filter = (
        "email",
        "is_staff",
        "is_active",
    )

    fieldsets = (
        (None, {"fields": ("email", "username", "password", "date_joined")}),
        ("Permissions", {"fields": ("is_staff", "is_active")}),
    )
    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": (
                    "email",
                    "username",
                    "password1",
                    "password2",
                    "is_staff",
                    "is_active",
                ),
            },
        ),
    )
    search_fields = ("email", "username")
    ordering = ("email",)


class ExpertiseAdmin(admin.ModelAdmin):
    list_filter = ["slug"]
    list_display = (
        "id",
        "name",
        "slug",
    )
    search_fields = [
        "name",
    ]
    list_per_page = 4

    prepopulated_fields = {"slug": ("name",)}
    
class CollegesAdmin(admin.ModelAdmin):
    list_filter = ["slug"]
    list_display = (
        "id",
        "name",
        "slug",
    )
    search_fields = [
        "name",
    ]
    list_per_page = 4

    prepopulated_fields = {"slug": ("name",)}


admin.site.register(User, User_Admin)
# admin.site.register(UserType)
admin.site.register(Lawyer)
admin.site.register(Expertise, ExpertiseAdmin)
admin.site.register(Colleges, CollegesAdmin)
admin.site.register(Client)
admin.site.register(CustomUser)



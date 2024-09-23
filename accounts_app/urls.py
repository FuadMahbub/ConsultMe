from django.contrib import admin
from django.urls import path, include
from .views import *
from accounts_app import views

urlpatterns = [
    path("client_register/", views.ClientSignUpView.as_view(), name="client"),
    path("lawyer_register/", views.LawyerSignUpView.as_view(), name="lawyer"),
    path("choose_user/", views.choose_user_view, name="choose"),
    path("choose_login/", views.choose_login_view, name="choose_login"),
    path("lawyer_login/", views.LawyerLoginView.as_view(), name="lawyerlogin"),
    path("client_login/", views.ClientLoginView.as_view(), name="clientlogin"),
    path("logout/", views.LogoutViewUser.as_view(), name="logout"),
    # ---------Home URL-------------
    path("lawyer_home/", views.lawyer_home_view, name="lawyer_home"),
    path("client_home/", views.client_home_view, name="client_home"),
    # -----------Profiles--------------
    # path('client_profile',)
    path("lawyer/profile/", LawyerProfileView.as_view(), name="lawyer_profile"),
    path("client/profile/", ClientProfileView.as_view(), name="client_profile"),
    # -----------Update Profile---------------
    path(
        "lawyer/profile/update/",
        UpdateLawyerProfileView.as_view(),
        name="update_lawyer_profile",
    ),
    path(
        "client/profile/update/",
        UpdateClientProfileView.as_view(),
        name="update_client_profile",
    ),
    path(
        "categories/<str:expertise_slug>/",
        views.lawyer_list,
        name="lawyerlist_by_expertise",
    ),
    path(
        "colleges/<str:colleges_slug>/",
        views.collegelist,
        name="collegelist",
    ),
]

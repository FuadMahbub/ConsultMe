"""
URL configuration for ConsultMe project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.contrib import admin
from django.urls import path, include
from accounts_app import views
from core_app import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path("admin/", admin.site.urls),
    # Home url
    path("", views.HomeView.as_view(), name="home"),
    # Account Url
    path("accounts/", include(("accounts_app.urls", "app_name"), namespace="accounts")),
    path("", include(("core_app.urls", "app_name"), namespace="core")),
    # Lawyer URL
    path("", include(("lawyer_app.urls", "app_name"), namespace="lawyer")),
    # Client URL
    path("", include(("client_app.urls", "app_name"), namespace="client")),

    path("", include(("case_app.urls", "app_name"), namespace="case")),
    
    path("", include(("billing_app.urls", "app_name"), namespace="billing")),
    
    path("", include(("lawyerchatbot.urls", "app_name"), namespace="chatbot")),
    
    #Chat app URL
    path("chat/", include(("chat_app.urls", "app_name"), namespace="chat")),
    path("blog/", include(("blog_app.urls", "app_name"), namespace="blog")),
    
    # path("", include(("lawyerchatbot.urls", "app_name"), namespace="bot")),
    
]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

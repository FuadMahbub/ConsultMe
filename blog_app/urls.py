from django.urls import path, include
from .views import *
from . import views

urlpatterns = [
    
    path ('my_blog_list/', views.MyBlogPostListView.as_view(), name='blog_post_list'),
    
    path ('blogs/', views.BlogPostListView.as_view(), name='bloglist'),
    path ('blogs/detail/<int:pk>/', views.BlogPostDetailView.as_view(), name='blogdetail'),
    
    path ('blogs/lawyer/detail/<int:pk>/', views.LawyerBlogPostDetailView.as_view(), name='lawyerblogdetail'),
    
    path ('blogs/client/detail/<int:pk>/', views.ClientBlogPostDetailView.as_view(), name='client_blog_detail'),
   
    path ('post/new/', views.BlogPostCreateView.as_view(), name='blog_post_new'),
    
    path ('post/<int:pk>/comment/', views.CommentCreateView.as_view(), name='comment_new'),
    
    path('lawyer/post/<int:pk>/', MyBlogPostDetailView.as_view(), name='blog_post_detail'),
    
    
    path(
        "lawyer/update_post/<int:pk>",
        views.BlogPostUpdateView.as_view(),
        name="update",
    ),
    path(
        "lawyer/delete_post/<int:pk>",
        views.BlogDeleteView.as_view(),
        name="delete",
    ),
]

from django.shortcuts import render
from .models import *
from django.urls import reverse_lazy
from django.views.generic import *
from django.views.generic.edit import FormView
from .forms import BlogPostForm, CommentForm
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.contrib import messages
from django.urls import reverse
# Create your views here.


class BlogPostCreateView(LoginRequiredMixin, UserPassesTestMixin, FormView):
    form_class = BlogPostForm
    template_name = 'blog_app/blogpost_form.html'
    
    
    def form_valid(self, form):
        form.instance.author = self.request.user
        form.save()
        return super().form_valid(form)
    
    def test_func(self):
        return self.request.user.lawyer
    
    def get_success_url(self):
        messages.success(self.request, "Blog Created Successfully...!!")
        return reverse('blog:blog_post_list')
   
class BlogDeleteView(LoginRequiredMixin,DeleteView):
    model = BlogPost
    template_name = "lawyer/delete.html"
    
    
    def get_success_url(self):
        messages.success(self.request, "BLOG Deleted Successfully...!!")
        return reverse('blog:blog_post_list') 
    
    
class BlogPostUpdateView(UpdateView):
    model = BlogPost
    template_name = "blog_app/blogpost_form.html"
    form_class = BlogPostForm

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["title"] = "Edit"
        context["heading"] = "Update BLOG Post"
        return context

    def get_success_url(self):
        messages.success(self.request, "Data Updated Successfully...!!")
        return reverse("blog:blog_post_list")
    
class MyBlogPostListView(LoginRequiredMixin, ListView):
    model = BlogPost
    template_name = 'blog_app/my_blogpost_list.html'
    context_object_name = "blog_posts"

    def get_queryset(self):
        # Filter posts to only those created by the logged-in lawyer
        return BlogPost.objects.filter(author=self.request.user)

    def test_func(self):
        # Assuming 'is_lawyer' is an attribute to check if the user is a lawyer
        return self.request.user.is_lawyer

class MyBlogPostDetailView(LoginRequiredMixin, DetailView):
    model = BlogPost
    template_name = 'blog_app/my_blogpost_list.html'
    context_object_name = "post"
    login_url = reverse_lazy('accounts:lawyerlogin')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        post = self.get_object()
        # Assuming 'post' is the correct field representing the relationship
        comments = Comment.objects.filter(post=post).order_by('-created_at')
        context['comments'] = comments
        return context

    





class CommentCreateView(LoginRequiredMixin, FormView):
    template_name = 'blog_app/comment_form.html'
    form_class = CommentForm

    def form_valid(self, form):
        form.instance.author = self.request.user
        form.instance.post_id = self.kwargs['pk']
        form.save()
        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy('blog:blogdetail', kwargs={'pk': self.kwargs['pk']})


class BlogPostListView(ListView):
    model = BlogPost
    template_name = 'blog_app/blogpost_list.html'
    context_object_name = "blog_posts"
    paginate_by = 10  # Optional: if you want to paginate the blog posts

    def get_queryset(self):
        # Return all posts
        return BlogPost.objects.all()
    
class LawyerBlogPostDetailView(DetailView):
    model = BlogPost
    form_class = CommentForm
    template_name = 'blog_app/lawyer_blogpost_detail.html'
    context_object_name = 'post'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        post = self.get_object()
        comments = Comment.objects.filter(post=post).order_by('-created_at')
        context['comments'] = comments
        context['form'] = self.form_class()
        return context
    
class ClientBlogPostDetailView(DetailView):
    model = BlogPost
    form_class = CommentForm
    template_name = 'blog_app/client_blogpost_detail.html'
    context_object_name = 'post'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        post = self.get_object()
        comments = Comment.objects.filter(post=post).order_by('-created_at')
        context['comments'] = comments
        context['form'] = self.form_class()
        return context
    
class BlogPostDetailView(DetailView):
    model = BlogPost
    form_class = CommentForm
    template_name = 'blog_app/my_blogpost_detail.html'
    context_object_name = 'post'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        post = self.get_object()
        comments = Comment.objects.filter(post=post).order_by('-created_at')
        context['comments'] = comments
        context['form'] = self.form_class()
        return context
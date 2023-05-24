from django.urls import path
from django .contrib.auth import views as auth_views

from authapp import views

urlpatterns = [
    path('register/', views.register, name='register'),
    path('login/', auth_views.LoginView.as_view,name='login'),
    # path('login/', views.login, name='login'),
]
from django.urls import path
from django .contrib.auth import views as auth_views

from authapp import views

urlpatterns = [
    path('register/', views.register, name='register'),
    path('login/', views.user_login, name='login'),
    path('addexpense/',views.add_expense,name='addexpense'),
    path('listexpense/',views.get_expense_list,name='expense'),
    path('deleteexpense/',views.delete_expense,name='deleteexpense'),
    path('updateexpense/',views.update_expense,name='updatexpense'),
]
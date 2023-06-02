import json
from django.shortcuts import render
from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User
from django.views.generic import DeleteView, ListView ,UpdateView,CreateView

from . import models

# Create your views here.
@csrf_exempt
def register(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')

        if not email or not password:
            return JsonResponse({'message': 'Email and password required'}, status=400)
        
        try:
            user = User.objects.create_user(username=email, email=email, password=password)
            user.save()
            return JsonResponse({'message': 'Registration successful'}, status=200)
        
        except:
            return JsonResponse({'message': 'Registration failed'}, status=500)

@csrf_exempt
def user_login(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')

        if not email or not password:
            return JsonResponse({'message': 'Invalid details'}, status=400)
        
        user = authenticate(request, username=email, password=password)
        
        if user is not None:
            auth_login(request, user)  
            return JsonResponse({'message': 'Login Successful'}, status=200)
        else:
            return JsonResponse({'message': 'Login failed'}, status=401)


@csrf_exempt
def add_expense(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        amount = request.POST.get('amount')
        description = request.POST.get('description')
        category = request.POST.get('category')

        if not title or not amount or not category or not description:
            return JsonResponse({'message': 'Missing required data'}, status=400)

        try:
            expense = models.Expense.objects.create(title=title, amount=amount, description=description, category=category)
            expense.save()
            return JsonResponse({'message': 'Expense added successfully'}, status=201)
        except Exception as e:
            return JsonResponse({'message': 'Failed to add expense', 'error': str(e)}, status=500)
    else:
        return JsonResponse({'message': 'Invalid request method'}, status=405)




def get_expense_list(request):
    expenses = models.Expense.objects.all()
    expense_list = []
    for expense in expenses:
        expense_data = {
            'id': expense.id,
            'title': expense.title,
            'amount': expense.amount,
            'description': expense.description,
            'category': expense.category
        }
        expense_list.append(expense_data)
    return JsonResponse({'expenses': expense_list}, status=200)


@csrf_exempt
def delete_expense(request):
    if request.method == 'POST':
        expense_id = request.POST.get('id')
        expense = models.Expense.objects.get(id=expense_id)
        expense.delete()
        return JsonResponse({'message': 'Deleted'}, status=200)
    else:
        return JsonResponse({'message':'Failed'}, status = 500)
    



@csrf_exempt
def update_expense(request):
    if request.method == 'POST':
        expense_id = request.POST.get('id')
        title = request.POST.get('title')
        description = request.POST.get('description')
        amount = request.POST.get('amount')
        category = request.POST.get('category')

        try:
            expense = models.Expense.objects.get(id=expense_id)
            expense.title = title
            expense.amount = amount
            expense.description = description
            expense.category = category
            expense.save()

            # Check if expense was updated successfully
            if (
                expense.title == title
                and expense.amount == amount
                and expense.description == description
                and expense.category == category
            ):
                return JsonResponse({'message': 'Expense updated successfully'})
            else:
                return JsonResponse({'error': 'Failed to update expense'})

        except models.Expense.DoesNotExist:
            return JsonResponse({'error': 'Expense does not exist'})

    else:
        return JsonResponse({'error': 'Invalid request method'})








    

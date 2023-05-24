from django.shortcuts import render
from django.contrib.auth import authenticate, login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User

# Create your views here.
@csrf_exempt
def register(request):
    if request.method =='POST':
        email = request.POST.get('email')
        password = request.POST.get('password')

        if not email or not password:
            return JsonResponse({'message':'Email and password required'},status = 400)
        
        try:
            user = User.objects.create_user(username=email,email=email,password=password)
            user.save()
            return JsonResponse({'message':'Registration successful'},status =200)
        
        except:
            return JsonResponse({'message':'Registration failed'},status = 500)
        
@csrf_exempt
def login(request):

    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')

        if not email or not password:
            return JsonResponse({'message':'Invalid details'},status=400)
        user = authenticate(request,username=email,password=password)
        if user is not None:
            login(request,user)
            return JsonResponse({'message':'Login Succesful'},status = 200)
        else:
            return JsonResponse({'message':'Login failed'},status = 401)

        
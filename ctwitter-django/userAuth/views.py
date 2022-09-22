from pickle import FALSE
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User
from django.views.decorators import csrf
from .serializers import userSerializer
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser

# Create your views here.

@csrf_exempt
def userSignup(request):
    if request.method == 'GET':
        data = User.objects.all()
        serialized = userSerializer(data, many = True)
        
        return JsonResponse(serialized.data, safe = False)
    
    elif request.method == 'POST':
        data = JSONParser().parse(request)
        
        serialized = userSerializer(data=data)
        if serialized.is_valid():
            serialized.save()
            return JsonResponse({"message": "success", "id": serialized.data["id"]})
        else:
            return JsonResponse(serialized.errors, status = 400)
        
    elif request.method == 'DELETE':
        data = JSONParser().parse(request)
        id = data["id"]
        try: 
            user = User.objects.filter(id = id)
            user.delete()
        
            return JsonResponse({"message": "success"})
        except:
            return JsonResponse({"message": "no such user"}, status = 404)
        

@csrf_exempt
def userLogin(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        
        email = data["email"]
        password = data["password"]
        
        user = User.objects.filter(email = email)
        if user.exists():
            user = user.first()
            
            if user.password == password:
                return JsonResponse({"message": "success", "id": user.id})
            else:
                return JsonResponse({"message": "fail", "data": "wrong password"})
            
        else:
            return JsonResponse({"message": "fail", "data": "no such user"})
    
@csrf_exempt
def userData(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        
        id = data["id"]
        user = User.objects.filter(id = id)
        if user.exists():
            user = user.first()
            
            return JsonResponse({"message": "success", 
                                 "data": {
                                     "username": user.username,
                                     "email": user.email,
                                     }})
            
        else:
            return JsonResponse({"message": "fail"}) 
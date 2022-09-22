import json
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User
from sqlalchemy import false
from .serializers import blogSerializer
from .models import Blog
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser

# Create your views here.
@csrf_exempt
def viewBlog(request):
    if request.method == 'GET':
        try: 
            blogs = Blog.objects.all()
            serialized = blogSerializer(blogs, many = True)
        
            return JsonResponse({"message": "success", "data": serialized.data}, safe=False)
        except:
            return JsonResponse({"message": "no data"})
    
    elif request.method == 'POST':
        data = JSONParser().parse(request)
        #print(type(data))
        
        content = data["content"]
        #userName = data["userName"]
        id = data["id"]
        date = data["date"]
        
        user = User.objects.filter(id = id)
        if (user.exists() and content != None and date != None):
            user = user.first()
            user.blog_set.create(content = content, userName = user.username, date = date)
        
            currBlog = Blog.objects.filter(userName = user.username, author = user)
            if currBlog != None:
                return JsonResponse({"message": "success"})
        
            return JsonResponse({"message": "fail"})
        
        else:
            return JsonResponse({"message": "Error in data"})
        
@csrf_exempt
def filterBlog(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        
        id = data["id"]
        user = User.objects.filter(id = id)
        
        if user.exists():
            user = user.first()
            blogs = Blog.objects.filter(author = user)
            
            serialData = blogSerializer(blogs, many = True)
            
            return JsonResponse({"message": "success", "data": serialData.data}, safe=False)
        
        else:
            return JsonResponse({"message": "no data"})

@csrf_exempt
def returnUsername(request):
    data = JSONParser().parse(request)
    
    id = data["id"]
    
    user = User.objects.filter(id = id)
    
    user = user.first()
    
    return JsonResponse({"message": "success", "username": user.username})
    
@csrf_exempt
def likePost(request):
    data = JSONParser().parse(request);
    
    bId = data["blogId"]
    uId = data["id"]
    blog = Blog.objects.filter(blogId = bId)
    
    blog = blog.first()
    blog.likesCount += 1;
    likedBy = json.loads(blog.likedBy)
    likedBy.append(uId)
    blog.likedBy = json.dumps(likedBy)
    blog.save()
    
    return JsonResponse({"message": "success"})

@csrf_exempt
def checkLiked(request):
    data = JSONParser().parse(request)
    
    bId = data["blogId"]
    uId = data["id"]
    blog = Blog.objects.filter(blogId = bId)
    blog = blog.first()
    
    likedBy = json.loads(blog.likedBy)
    
    for i in likedBy:
        if i == uId:
            return JsonResponse({"message": "yes"})
        
    return JsonResponse({"message": "no"})
            
    
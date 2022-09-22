from tkinter import CASCADE
from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Blog(models.Model):
    blogId = models.BigAutoField(primary_key=True)
    content = models.TextField(max_length = 800)
    date = models.CharField(max_length=20)
    userName = models.CharField(max_length=50)
    likesCount = models.PositiveIntegerField(default=0)
    likedBy = models.TextField(default="[]")
    author = models.ForeignKey(User, on_delete= models.CASCADE)

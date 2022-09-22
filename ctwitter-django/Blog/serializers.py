from rest_framework import serializers
from .models import Blog

class blogSerializer(serializers.ModelSerializer):
    class Meta:
        model = Blog
        fields = ['blogId','content', 'date', 'userName', 'author', 'likesCount', 'likedBy']
        
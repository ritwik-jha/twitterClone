from django.urls import path, include
from .views import checkLiked, filterBlog, likePost, returnUsername, viewBlog

urlpatterns = [
    path("viewBlogs/", viewBlog, name = "viewBlogs"),
    path("filterBlogs/", filterBlog, name = "filterBlogs"),
    path("returnUsername/", returnUsername, name = "returnUsername"),
    path("likePost/", likePost, name = "likePost"),
    path("checkLiked/", checkLiked, name = "checkLiked")
]
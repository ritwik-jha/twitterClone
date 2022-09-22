from django.urls import path
from .views import userData, userLogin, userSignup

urlpatterns = [
    path('userSignup/', userSignup, name = 'userSignup'),
    path('userLogin/', userLogin, name = 'userLogin'),
    path('userData/', userData, name = "userData")
]
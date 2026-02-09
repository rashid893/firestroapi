from django.urls import path
from . import views

urlpatterns = [
    path("create/", views.create_user),
    path("list/", views.list_users),
    path("update/<str:user_id>/", views.update_user),
    path("delete/<str:user_id>/", views.delete_user),
]
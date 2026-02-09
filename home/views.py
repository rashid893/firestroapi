from django.shortcuts import render

# Create your views here.
from django.http import JsonResponse
from .firestore import get_db

# CREATE
def create_user(request):
    db = get_db()
    user_ref = db.collection("users").document()

    user_ref.set({
        "name": "Rnnnashid",
        "email": "jrashid@gmail.com",
        "age": 25
    })

    return JsonResponse({
        "message": "User created",
        "id": user_ref.id
    })


# READ
def list_users(request):
    db = get_db()
    users = db.collection("users").stream()

    data = []
    for user in users:
        d = user.to_dict()
        d["id"] = user.id
        data.append(d)

    return JsonResponse(data, safe=False)


# UPDATE
def update_user(request, user_id):
    db = get_db()
    db.collection("users").document(user_id).update({
        "age": 30
    })

    return JsonResponse({"message": "User updated"})


# DELETE
def delete_user(request, user_id):
    db = get_db()
    db.collection("users").document(user_id).delete()
    return JsonResponse({"message": "User deleted"})
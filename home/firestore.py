from google.cloud import firestore

db = firestore.Client()

def get_db():
    return db


# firestore.py
from google.cloud import firestore

def get_db():
    return firestore.Client()
from google.cloud import firestore

db = firestore.Client()

def get_db():
    return db
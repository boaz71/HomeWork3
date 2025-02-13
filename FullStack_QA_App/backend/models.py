from pymongo import MongoClient
from config import MONGO_URI

try:
    client = MongoClient(MONGO_URI)
    client.admin.command('ping')  # בדיקה אם ניתן להתחבר
    print("✅ Flask מחובר ל-MongoDB בהצלחה")
except Exception as e:
    print("❌ Flask לא מצליח להתחבר ל-MongoDB:", e)

db = client["qa_forum"]
questions_collection = db["questions"]
answers_collection = db["answers"]

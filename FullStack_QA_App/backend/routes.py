from flask import Blueprint, jsonify, request
from flask_cors import CORS
from models import questions_collection
from bson.objectid import ObjectId

api = Blueprint('api', __name__)
CORS(api, resources={r"/*": {"origins": "*"}})  # CORS מופעל לכל הנתיבים

@api.route('/questions', methods=['POST'])
def create_question():
    data = request.json
    if not data or "title" not in data or "description" not in data:
        return jsonify({"error": "Missing fields"}), 400

    question = {
        "title": data["title"],
        "description": data["description"],
        "answers": []
    }
    question_id = questions_collection.insert_one(question).inserted_id
    return jsonify({"id": str(question_id)}), 201

@api.route('/questions', methods=['GET'])
def get_questions():
    questions = list(questions_collection.find({}, {"_id": 1, "title": 1, "description": 1, "answers": 1}))  # הוספת "answers"
    return jsonify([
        {
            "id": str(q["_id"]),
            "title": q["title"],
            "description": q.get("description", ""),
            "answers": q.get("answers", [])  # אם אין תשובות, נחזיר רשימה ריקה
        }
        for q in questions
    ])


# 🔹 עדכון שאלה לפי מזהה (ID)
@api.route('/questions/<question_id>', methods=['PUT'])
def update_question(question_id):
    data = request.json
    if "title" not in data or "description" not in data:
        return jsonify({"error": "Missing fields"}), 400

    result = questions_collection.update_one(
        {"_id": ObjectId(question_id)},
        {"$set": {"title": data["title"], "description": data["description"]}}
    )

    if result.matched_count == 0:
        return jsonify({"error": "Question not found"}), 404

    return jsonify({"message": "Question updated"}), 200

# 🔹 מחיקת שאלה לפי מזהה (ID)
@api.route('/questions/<question_id>', methods=['DELETE'])
def delete_question(question_id):
    result = questions_collection.delete_one({"_id": ObjectId(question_id)})

    if result.deleted_count == 0:
        return jsonify({"error": "Question not found"}), 404

    return jsonify({"message": "Question deleted"}), 200

# 🔹 הוספת תשובה לשאלה קיימת
@api.route('/questions/<question_id>/answers', methods=['POST'])
def add_answer(question_id):
    data = request.json
    if "answer" not in data:
        return jsonify({"error": "Missing answer text"}), 400

    result = questions_collection.update_one(
        {"_id": ObjectId(question_id)},
        {"$push": {"answers": data["answer"]}}
    )

    if result.matched_count == 0:
        return jsonify({"error": "Question not found"}), 404

    return jsonify({"message": "Answer added"}), 201

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5000";

  // שליפת כל השאלות מהשרת
  Future<List<dynamic>> getQuestions() async {
    final response = await http.get(Uri.parse("$baseUrl/questions"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("❌ שגיאה בטעינת השאלות: ${response.statusCode}");
    }
  }

  // יצירת שאלה חדשה
  Future<void> createQuestion(String title, String description) async {
    final response = await http.post(
      Uri.parse("$baseUrl/questions"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title, "description": description}),
    );

    if (response.statusCode != 201) {
      throw Exception("❌ שגיאה ביצירת שאלה: ${response.statusCode}");
    }
  }

  // 🔹 עדכון שאלה קיימת
  Future<void> updateQuestion(
      String id, String title, String description) async {
    final response = await http.put(
      Uri.parse("$baseUrl/questions/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title, "description": description}),
    );

    if (response.statusCode != 200) {
      throw Exception("❌ שגיאה בעדכון שאלה: ${response.statusCode}");
    }
  }

  // 🔹 מחיקת שאלה לפי ID
  Future<void> deleteQuestion(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/questions/$id"));

    if (response.statusCode != 200) {
      throw Exception("❌ שגיאה במחיקת שאלה: ${response.statusCode}");
    }
  }

  // 🔹 הוספת תשובה לשאלה
  Future<void> addAnswer(String questionId, String answer) async {
    final response = await http.post(
      Uri.parse("$baseUrl/questions/$questionId/answers"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"answer": answer}),
    );

    if (response.statusCode != 201) {
      throw Exception("❌ שגיאה בהוספת תשובה: ${response.statusCode}");
    }
  }
}

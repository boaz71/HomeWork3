import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/question_item.dart';
import '../widgets/dialogs.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> questions = [];

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  // טעינת השאלות מה-Backend
  void fetchQuestions() async {
    try {
      List<dynamic> fetchedQuestions = await apiService.getQuestions();
      setState(() {
        questions = fetchedQuestions;
      });
    } catch (e) {
      print("❌ שגיאה בטעינת השאלות: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('שאלות ותשובות')),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return QuestionItem(
                  question: questions[index],
                  onUpdate: fetchQuestions, // ריענון לאחר פעולה
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showAddQuestionDialog(context, apiService, fetchQuestions),
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dialogs.dart';

class QuestionItem extends StatelessWidget {
  final dynamic question;
  final Function onUpdate;
  final ApiService apiService = ApiService();

  QuestionItem({required this.question, required this.onUpdate});

  void deleteQuestion() async {
    await apiService.deleteQuestion(question['id']);
    onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              question['description'] ?? "אין תיאור",
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Text(
              "תשובות:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ...((question['answers'] ?? []) as List)
                .map<Widget>((answer) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Icon(Icons.comment,
                              size: 16, color: Colors.grey[600]),
                          SizedBox(width: 5),
                          Expanded(child: Text(answer)),
                        ],
                      ),
                    ))
                .toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    showEditQuestionDialog(
                        context, apiService, question, onUpdate);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: deleteQuestion,
                ),
                IconButton(
                  icon: Icon(Icons.add_comment, color: Colors.green),
                  onPressed: () {
                    showAddAnswerDialog(
                        context, apiService, question['id'], onUpdate);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

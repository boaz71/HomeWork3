import 'package:flutter/material.dart';
import '../services/api_service.dart';

void showAddQuestionDialog(
    BuildContext context, ApiService apiService, Function onUpdate) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("הוסף שאלה חדשה"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "כותרת השאלה"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "תיאור השאלה"),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text("ביטול"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text("שמור"),
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                await apiService.createQuestion(
                    titleController.text, descriptionController.text);
                onUpdate();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

void showEditQuestionDialog(BuildContext context, ApiService apiService,
    dynamic question, Function onUpdate) {
  TextEditingController titleController =
      TextEditingController(text: question['title']);
  TextEditingController descriptionController =
      TextEditingController(text: question['description']);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("עריכת שאלה"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "כותרת")),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "תיאור")),
          ],
        ),
        actions: [
          TextButton(
              child: Text("ביטול"),
              onPressed: () => Navigator.of(context).pop()),
          TextButton(
            child: Text("שמור"),
            onPressed: () async {
              await apiService.updateQuestion(question['id'],
                  titleController.text, descriptionController.text);
              onUpdate();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showAddAnswerDialog(BuildContext context, ApiService apiService,
    String questionId, Function onUpdate) {
  TextEditingController answerController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("הוסף תשובה"),
        content: TextField(
            controller: answerController,
            decoration: InputDecoration(labelText: "תשובה")),
        actions: [
          TextButton(
              child: Text("ביטול"),
              onPressed: () => Navigator.of(context).pop()),
          TextButton(
            child: Text("שמור"),
            onPressed: () async {
              await apiService.addAnswer(questionId, answerController.text);
              onUpdate();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

# FullStack QA Forum

## תיאור הפרויקט

אפליקציה לניהול שאלות ותשובות המבוססת על Flask ל-Backend, Flutter ל-Frontend, ו-MongoDB כמסד נתונים. האפליקציה מאפשרת למשתמשים להוסיף, לערוך, למחוק ולענות על שאלות.

## התקנה והפעלה

### דרישות מקדימות

- Python 3.8+
- Flutter 3.0+
- MongoDB 6.0+

### הורדת הפרויקט והתקנה

1. שכפול הפרויקט:
   ```sh
   git clone https://github.com/boaz71/HomeWork3
   cd FullStack_QA_App
   ```

2. התקנת ה-Backend:
   ```sh
   cd backend
   python -m venv venv
   source venv/bin/activate  # ב-Windows השתמש בvenv\Scripts\activate
   pip install -r requirements.txt
   ```

3. התקנת ה-Frontend:
   ```sh
   cd ../frontend
   flutter pub get
   ```

### הפעלת האפליקציה

1. הפעלת מסד הנתונים MongoDB:
   ```sh
   mongod --dbpath "C:\data\db"  # ב-Windows
   sudo systemctl start mongod  # ב-Linux
   ```

2. הפעלת ה-Backend:
   ```sh
   cd backend
   source venv/bin/activate  # ב-Windows השתמש בvenv\Scripts\activate
   python app.py
   ```
   ברירת המחדל: `http://localhost:5000`

3. הפעלת ה-Frontend:
   ```sh
   cd frontend
   flutter run -d chrome
   ```


```

## דוגמאות שימוש ב-API

**קבלת רשימת שאלות:**
```sh
GET http://localhost:5000/questions
```

**הוספת שאלה חדשה:**
```sh
POST http://localhost:5000/questions
Content-Type: application/json

{
  "title": "איך משתמשים ב-Flutter?",
  "description": "שאלה על תחילת עבודה עם Flutter."
}
```

**מחיקת שאלה:**
```sh
DELETE http://localhost:5000/questions/{question_id}
```

**הוספת תשובה לשאלה:**
```sh
POST http://localhost:5000/questions/{question_id}/answers
Content-Type: application/json

{
  "answer": "Flutter היא פלטפורמה לפיתוח אפליקציות חוצות פלטפורמות."
}
```




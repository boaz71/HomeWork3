from flask import Flask
from flask_cors import CORS
from flask_socketio import SocketIO
from routes import api

app = Flask(__name__)

# פתרון מלא ל-CORS - מאשר קריאות מכל מקור
CORS(app, supports_credentials=True)

# הגדרת WebSockets עם CORS
socketio = SocketIO(app, cors_allowed_origins="*")

app.register_blueprint(api)

if __name__ == '__main__':
    socketio.run(app, debug=True, host="0.0.0.0", port=5000)

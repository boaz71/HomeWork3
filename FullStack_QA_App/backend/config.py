import os
from dotenv import load_dotenv

load_dotenv()

MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017/qa_forum")
SECRET_KEY = os.getenv("SECRET_KEY", "supersecret")

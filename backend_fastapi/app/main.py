from fastapi import FastAPI

from app.routes import auth
from app.routes import article
from app.routes import tips
from app.routes import counselor
from app.routes import history
from app.routes import chat

app = FastAPI(
    title="Mental Health Chatbot API",
    version="1.0.0"
)

app.include_router(auth.router)
app.include_router(article.router)
app.include_router(tips.router)
app.include_router(counselor.router)
app.include_router(history.router)
app.include_router(chat.router)

@app.get("/")
def root():

    return {
        "message":
        "Mental Health API Running"
    }
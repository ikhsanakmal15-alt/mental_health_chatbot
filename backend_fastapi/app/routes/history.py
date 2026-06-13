from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.db import get_db
from app.models.chat import Chat
from app.models.message import Message

router = APIRouter(prefix="/history")


@router.get("/{user_id}")
def get_history(
    user_id: int,
    db: Session = Depends(get_db)
):

    chats = (
        db.query(Chat)
        .filter(Chat.user_id == user_id)
        .order_by(Chat.created_at.desc())
        .all()
    )

    history = []

    for chat in chats:

        messages = (
            db.query(Message)
            .filter(Message.chat_id == chat.id)
            .order_by(Message.id.asc())
            .all()
        )

        history.append({
            "chat_id": chat.id,
            "user_id": chat.user_id,
            "created_at": str(chat.created_at),
            "messages": [
                {
                    "sender": msg.sender,
                    "message": msg.message
                }
                for msg in messages
            ]
        })

    return history
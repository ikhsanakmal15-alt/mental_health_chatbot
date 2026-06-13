from sqlalchemy.orm import Session
from app.models.message import Message


def save_message(
    db: Session,
    chat_id: int,
    sender: str,
    message: str
):
    new_message = Message(
        chat_id=chat_id,
        sender=sender,
        message=message
    )

    db.add(new_message)
    db.commit()
    db.refresh(new_message)

    return new_message
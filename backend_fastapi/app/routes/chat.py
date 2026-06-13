from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.db import get_db
from app.models.chat import Chat
from app.services.chat_service import save_message
from app.services.rasa_service import send_to_rasa

router = APIRouter()


@router.post("/chat")
def chat(
    data: dict,
    db: Session = Depends(get_db)
):
    user_id = data.get("user_id", 1)
    user_message = data.get("message", "").strip()

    if not user_message:
        return {
            "reply": "Pesan kosong."
        }

    # Buat sesi chat baru
    chat = Chat(user_id=user_id)
    db.add(chat)
    db.commit()
    db.refresh(chat)

    # Simpan pesan user
    save_message(
        db=db,
        chat_id=chat.id,
        sender="user",
        message=user_message
    )

    # Kirim ke Rasa
    rasa_response = send_to_rasa(user_message)

    if rasa_response and len(rasa_response) > 0:
        bot_reply = rasa_response[0].get(
            "text",
            "Maaf, saya belum memahami pertanyaan Anda."
        )
    else:
        bot_reply = "Maaf, saya belum memahami pertanyaan Anda."

    # Simpan balasan bot
    save_message(
        db=db,
        chat_id=chat.id,
        sender="bot",
        message=bot_reply
    )

    return {
        "chat_id": chat.id,
        "reply": bot_reply
    }
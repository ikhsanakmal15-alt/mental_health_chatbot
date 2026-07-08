from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.db import get_db
from app.models.chat import Chat
from app.models.user import User
from app.services.chat_service import save_message
from app.services.rasa_service import send_to_rasa

router = APIRouter()


@router.post("/chat")
def chat(
    data: dict,
    db: Session = Depends(get_db)
):

    user_id = data.get("user_id")
    user_message = data.get("message", "").strip()


    # ==========================
    # VALIDASI INPUT
    # ==========================
    if not user_id:
        raise HTTPException(
            status_code=400,
            detail="User ID tidak ditemukan"
        )


    if not user_message:
        return {
            "reply": "Pesan kosong."
        }


    # ==========================
    # CEK USER ADA ATAU TIDAK
    # ==========================
    user = db.query(User).filter(
        User.id == user_id
    ).first()


    if not user:
        raise HTTPException(
            status_code=404,
            detail=f"User dengan id {user_id} tidak ditemukan"
        )


    # ==========================
    # BUAT SESSION CHAT
    # ==========================
    chat = Chat(
        user_id=user.id
    )

    db.add(chat)
    db.commit()
    db.refresh(chat)


    # ==========================
    # SIMPAN PESAN USER
    # ==========================
    save_message(
        db=db,
        chat_id=chat.id,
        sender="user",
        message=user_message
    )


    # ==========================
    # KIRIM KE RASA
    # ==========================
    rasa_response = send_to_rasa(
        user_message
    )


    if rasa_response:

        bot_reply = rasa_response[0].get(
            "text",
            "Maaf, saya belum memahami pesan Anda."
        )

    else:

        bot_reply = (
            "Maaf, saya belum memahami pesan Anda."
        )


    # ==========================
    # SIMPAN RESPONSE BOT
    # ==========================
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
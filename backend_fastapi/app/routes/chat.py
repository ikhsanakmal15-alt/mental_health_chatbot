import time

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
    start_time = time.time()

    # ============================================================
    # AMBIL DATA
    # ============================================================

    user_id = data.get("user_id")
    user_message = data.get("message", "").strip()

    # ============================================================
    # VALIDASI
    # ============================================================

    if not user_id:
        raise HTTPException(
            status_code=400,
            detail="User ID tidak ditemukan"
        )

    if not user_message:
        return {
            "reply": "Pesan kosong."
        }

    # ============================================================
    # CEK USER
    # ============================================================

    user_start = time.time()

    user = (
        db.query(User.id)
        .filter(User.id == user_id)
        .first()
    )

    user_time = time.time() - user_start

    print(
        f"USER QUERY TIME: {user_time:.3f} detik"
    )

    if not user:
        raise HTTPException(
            status_code=404,
            detail=f"User dengan id {user_id} tidak ditemukan"
        )

    # ============================================================
    # BUAT CHAT
    # ============================================================

    chat_start = time.time()

    chat = Chat(
        user_id=user.id
    )

    db.add(chat)

    # flush hanya mengirim INSERT ke database
    # tanpa melakukan commit transaction
    db.flush()

    chat_time = time.time() - chat_start

    print(
        f"CHAT CREATE TIME: {chat_time:.3f} detik"
    )

    # ============================================================
    # SIMPAN PESAN USER
    # ============================================================

    message_start = time.time()

    save_message(
        db=db,
        chat_id=chat.id,
        sender="user",
        message=user_message,
        commit=False
    )

    message_time = time.time() - message_start

    print(
        f"USER MESSAGE SAVE TIME: "
        f"{message_time:.3f} detik"
    )

    # ============================================================
    # KIRIM KE RASA
    # ============================================================

    rasa_start = time.time()

    try:
        rasa_response = send_to_rasa(
            user_message,
            sender_id=f"user_{user.id}"
        )

    except Exception as e:
        print(
            f"RASA ERROR: {e}"
        )

        db.rollback()

        raise HTTPException(
            status_code=503,
            detail="Chatbot sedang tidak tersedia."
        )

    rasa_time = time.time() - rasa_start

    print(
        f"RASA RESPONSE TIME: "
        f"{rasa_time:.2f} detik"
    )

    # ============================================================
    # AMBIL RESPONSE BOT
    # ============================================================

    if rasa_response:
        bot_reply = rasa_response[0].get(
            "text",
            "Maaf, saya belum memahami pesan Anda."
        )
    else:
        bot_reply = (
            "Maaf, saya belum memahami pesan Anda."
        )

    # ============================================================
    # SIMPAN RESPONSE BOT
    # ============================================================

    bot_start = time.time()

    save_message(
        db=db,
        chat_id=chat.id,
        sender="bot",
        message=bot_reply,
        commit=False
    )

    bot_time = time.time() - bot_start

    print(
        f"BOT MESSAGE SAVE TIME: "
        f"{bot_time:.3f} detik"
    )

    # ============================================================
    # SATU COMMIT
    # ============================================================

    commit_start = time.time()

    db.commit()

    commit_time = time.time() - commit_start

    print(
        f"DATABASE COMMIT TIME: "
        f"{commit_time:.3f} detik"
    )

    # ============================================================
    # TOTAL RESPONSE TIME
    # ============================================================

    total_time = time.time() - start_time

    print(
        "========================================"
    )

    print(
        f"TOTAL CHAT RESPONSE: "
        f"{total_time:.2f} detik"
    )

    print(
        "========================================"
    )

    # ============================================================
    # RESPONSE
    # ============================================================

    return {
        "chat_id": chat.id,
        "reply": bot_reply
    }
from fastapi import APIRouter
from app.services.rasa_service import send_to_rasa

router = APIRouter()

@router.post("/chat")
def chat(data: dict):

    user_message = data["message"]

    rasa_response = send_to_rasa(
        user_message
    )

    if rasa_response:

        return {
            "reply": rasa_response[0].get(
                "text",
                ""
            )
        }

    return {
        "reply": "Maaf, saya belum memahami pesan Anda."
    }
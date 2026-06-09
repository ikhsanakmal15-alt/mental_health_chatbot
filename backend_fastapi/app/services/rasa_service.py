import requests

RASA_URL = "http://localhost:5005/webhooks/rest/webhook"

def send_to_rasa(message: str):

    payload = {
        "sender": "user",
        "message": message
    }

    response = requests.post(
        RASA_URL,
        json=payload
    )

    return response.json()
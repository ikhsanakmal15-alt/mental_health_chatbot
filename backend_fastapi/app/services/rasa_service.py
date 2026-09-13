import requests


RASA_URL = "http://localhost:5005/webhooks/rest/webhook"


def send_to_rasa(message: str, sender_id: str = "user"):
    payload = {
        "sender": sender_id,
        "message": message
    }

    try:
        response = requests.post(
            RASA_URL,
            json=payload,
            timeout=15
        )

        response.raise_for_status()

        return response.json()

    except requests.exceptions.Timeout:
        print("RASA ERROR: Request timeout")
        return []

    except requests.exceptions.ConnectionError:
        print("RASA ERROR: Tidak dapat terhubung ke Rasa")
        return []

    except requests.exceptions.RequestException as e:
        print(f"RASA ERROR: {e}")
        return []
from sqlalchemy.orm import Session

from app.models.message import Message


def save_message(
    db: Session,
    chat_id: int,
    sender: str,
    message: str,
    commit: bool = True
):
    """
    Menyimpan pesan ke database.

    commit=True
        Digunakan jika fungsi dipanggil sendiri.

    commit=False
        Digunakan ketika beberapa operasi database
        ingin digabung menjadi satu transaction.
    """

    new_message = Message(
        chat_id=chat_id,
        sender=sender,
        message=message
    )

    db.add(new_message)

    if commit:
        db.commit()
        db.refresh(new_message)

    return new_message
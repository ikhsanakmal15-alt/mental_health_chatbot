from sqlalchemy import Column, Integer, String, Text

from app.database.base import Base


class Message(Base):
    __tablename__ = "messages"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    chat_id = Column(
        Integer,
        nullable=False
    )

    sender = Column(
        String,
        nullable=False
    )

    message = Column(
        Text,
        nullable=False
    )
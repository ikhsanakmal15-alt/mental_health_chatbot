from sqlalchemy import *

from app.database.base import Base

class Message(Base):

    __tablename__ = "messages"

    id = Column(
        Integer,
        primary_key=True
    )

    chat_id = Column(Integer)

    sender = Column(String)

    message = Column(Text)
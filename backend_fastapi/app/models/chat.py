from sqlalchemy import *

from app.database.base import Base

class Chat(Base):

    __tablename__ = "chats"

    id = Column(
        Integer,
        primary_key=True
    )

    user_id = Column(Integer)
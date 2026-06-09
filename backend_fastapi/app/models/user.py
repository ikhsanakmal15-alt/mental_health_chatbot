from sqlalchemy import *

from app.database.base import Base

class User(Base):

    __tablename__ = "users"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    fullname = Column(String)

    email = Column(
        String,
        unique=True
    )

    password = Column(String)
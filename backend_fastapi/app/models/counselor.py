from sqlalchemy import *

from app.database.base import Base

class Counselor(Base):

    __tablename__ = "counselors"

    id = Column(
        Integer,
        primary_key=True
    )

    name = Column(String)

    phone = Column(String)

    schedule = Column(String)
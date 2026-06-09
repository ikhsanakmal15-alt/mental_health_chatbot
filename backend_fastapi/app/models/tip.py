from sqlalchemy import *

from app.database.base import Base

class Tip(Base):

    __tablename__ = "tips"

    id = Column(
        Integer,
        primary_key=True
    )

    title = Column(String)

    content = Column(Text)
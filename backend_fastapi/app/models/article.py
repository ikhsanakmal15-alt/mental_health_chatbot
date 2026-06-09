from sqlalchemy import *

from app.database.base import Base

class Article(Base):

    __tablename__ = "articles"

    id = Column(
        Integer,
        primary_key=True
    )

    title = Column(String)

    content = Column(Text)
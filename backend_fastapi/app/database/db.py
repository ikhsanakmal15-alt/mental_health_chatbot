from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session


# ============================================================
# DATABASE URL - SUPABASE SESSION POOLER
# ============================================================

DATABASE_URL = (
    "postgresql+psycopg2://"
    "postgres.razvyivbaijqizdmncgt:"
    "postgres123%21"
    "@aws-1-ap-southeast-2.pooler.supabase.com:5432/postgres"
    "?sslmode=require"
)


# ============================================================
# SQLAlchemy Engine
# ============================================================

engine = create_engine(
    DATABASE_URL,
    pool_pre_ping=True,
    pool_recycle=300,
    echo=True,
)


# ============================================================
# Database Session
# ============================================================

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine,
)


# ============================================================
# Dependency untuk FastAPI
# ============================================================

def get_db():
    db: Session = SessionLocal()

    try:
        yield db
    finally:
        db.close()
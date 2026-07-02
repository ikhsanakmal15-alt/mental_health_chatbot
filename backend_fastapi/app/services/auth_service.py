from sqlalchemy.orm import Session
from app.models.user import User
from app.utils.hash import hash_password, verify_password
from app.utils.jwt_handler import create_access_token


# =========================
# REGISTER USER
# =========================
def register_user(db: Session, name: str, email: str, password: str):
    existing_user = db.query(User).filter(User.email == email).first()

    if existing_user:
        return None

    hashed_password = hash_password(password)

    new_user = User(
        fullname=name,   
        email=email,
        password=hashed_password
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return new_user


# =========================
# LOGIN USER
# =========================
def login_user(db: Session, email: str, password: str):

    user = db.query(User).filter(User.email == email).first()

    if not user:
        return None

    if not verify_password(password, user.password):
        return None

    token = create_access_token({
        "user_id": user.id,
        "email": user.email
    })

    return {
        "access_token": token,
        "token_type": "bearer",
        "user": {
            "id": user.id,
            "name": user.fullname,   # ✅ FIX DI SINI JUGA
            "email": user.email
        }
    }
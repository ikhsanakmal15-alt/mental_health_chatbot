from sqlalchemy.orm import Session

from models.user import User
from utils.hash import hash_password, verify_password
from utils.jwt_handler import create_access_token


def register_user(
    db: Session,
    name: str,
    email: str,
    password: str
):
    # cek email sudah ada atau belum
    existing_user = (
        db.query(User)
        .filter(User.email == email)
        .first()
    )

    if existing_user:
        return None

    # hash password
    hashed_password = hash_password(password)

    # simpan user baru
    new_user = User(
        name=name,
        email=email,
        password=hashed_password
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return new_user


def login_user(
    db: Session,
    email: str,
    password: str
):
    user = (
        db.query(User)
        .filter(User.email == email)
        .first()
    )

    if not user:
        return None

    # cek password
    if not verify_password(
        password,
        user.password
    ):
        return None

    # buat JWT token
    token = create_access_token(
        {
            "user_id": user.id,
            "email": user.email
        }
    )

    return {
        "access_token": token,
        "token_type": "bearer",
        "user": {
            "id": user.id,
            "name": user.name,
            "email": user.email
        }
    }
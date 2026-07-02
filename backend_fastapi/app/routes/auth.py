from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.schemas.user_schema import RegisterSchema, LoginSchema
from app.database.db import get_db
from app.services.auth_service import register_user, login_user

router = APIRouter(prefix="/auth", tags=["Auth"])


# =========================
# REGISTER
# =========================
@router.post("/register")
def register(data: RegisterSchema, db: Session = Depends(get_db)):

    user = register_user(
        db=db,
        name=data.fullname,
        email=data.email,
        password=data.password
    )

    if not user:
        raise HTTPException(
            status_code=400,
            detail="Email sudah digunakan"
        )

    return {
        "status": "success",
        "message": "register success",
        "user": {
            "id": user.id,
            "name": user.fullname,
            "email": user.email
        }
    }


# =========================
# LOGIN
# =========================
@router.post("/login")
def login(data: LoginSchema, db: Session = Depends(get_db)):

    result = login_user(
        db=db,
        email=data.email,
        password=data.password
    )

    if not result:
        raise HTTPException(
            status_code=401,
            detail="Email atau password salah"
        )

    return {
        "status": "success",
        "access_token": result["access_token"],
        "token_type": result["token_type"],
        "user": result["user"]
    }
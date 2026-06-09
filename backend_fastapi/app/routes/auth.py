from fastapi import APIRouter

from app.schemas.user_schema import *

from app.utils.jwt_handler import create_token

router = APIRouter(
    prefix="/auth"
)

@router.post("/register")

def register(
    data:RegisterSchema
):

    return {
        "message":"register success"
    }

@router.post("/login")

def login(
    data:LoginSchema
):

    token = create_token({
        "email":data.email
    })

    return {
        "token":token
    }
from fastapi import APIRouter

router = APIRouter(
    prefix="/tips"
)

@router.get("/")
def get_tips():

    return []
from fastapi import APIRouter

router = APIRouter(
    prefix="/counselors"
)

@router.get("/")
def get_all():

    return []
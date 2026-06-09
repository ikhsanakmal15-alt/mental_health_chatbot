from fastapi import APIRouter

router = APIRouter(
    prefix="/history"
)

@router.get("/{user_id}")

def history(
    user_id:int
):

    return {
        "history":[]
    }
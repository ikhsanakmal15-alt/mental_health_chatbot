from fastapi import APIRouter

router = APIRouter(
    prefix="/articles"
)

@router.get("/")
def get_articles():

    return []

@router.post("/")
def create_article():

    return {
        "message":"article created"
    }

@router.put("/{id}")
def update_article(
    id:int
):

    return {
        "message":"updated"
    }

@router.delete("/{id}")
def delete_article(
    id:int
):

    return {
        "message":"deleted"
    }
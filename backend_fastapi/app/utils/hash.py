from passlib.context import CryptContext
import hashlib

pwd_context = CryptContext(
    schemes=["bcrypt"],
    deprecated="auto"
)

def hash_password(password: str):
    if not password:
        raise ValueError("Password kosong")

    # FIX 72 byte limit bcrypt
    safe = hashlib.sha256(password.encode()).hexdigest()

    return pwd_context.hash(safe)


def verify_password(plain, hashed):
    safe = hashlib.sha256(plain.encode()).hexdigest()
    return pwd_context.verify(safe, hashed)
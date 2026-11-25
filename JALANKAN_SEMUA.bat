
@echo off
title MENJALANKAN CHATBOT KESEHATAN MENTAL

echo ==========================================
echo    MENJALANKAN SEMUA LAYANAN CHATBOT
echo ==========================================

echo.
echo [1/4] Menjalankan Rasa API...

start "TAB 1 - RASA API" cmd /k "cd /d C:\mental_health\rasa_nlp && call rasa_env\Scripts\activate.bat && rasa run --enable-api --cors "*""

timeout /t 3 /nobreak >nul

echo [2/4] Menjalankan Rasa Actions...

start "TAB 2 - RASA ACTIONS" cmd /k "cd /d C:\mental_health\rasa_nlp && call rasa_env\Scripts\activate.bat && rasa run actions"

timeout /t 3 /nobreak >nul

echo [3/4] Menjalankan FastAPI...

start "TAB 3 - FASTAPI" cmd /k "cd /d C:\mental_health\backend_fastapi && call venv\Scripts\activate.bat && uvicorn app.main:app --host 127.0.0.1 --port 8000"

timeout /t 3 /nobreak >nul

echo [4/4] Menjalankan Ngrok...

start "TAB 4 - NGROK" cmd /k "cd /d C:\mental_health && ngrok http 8000"

echo.
echo ==========================================
echo SEMUA PERINTAH TELAH DIJALANKAN
echo JANGAN TUTUP KEEMPAT JENDELA SERVER
echo ==========================================

pause

FROM rasa/rasa:3.6.20

WORKDIR /app

COPY . .

RUN rasa train

CMD ["rasa", "run", "--enable-api", "--cors", "*", "-p", "10000"]
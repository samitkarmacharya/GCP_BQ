import os
from flask import Flask, jsonify

from demo_tasks import PrintHello, PrintGoodbye, ErrorRandomly

app = Flask(__name__)

APP_NAME = os.getenv("APP_NAME", "demo-dag")
MESSAGE_PREFIX = os.getenv("MESSAGE_PREFIX", "Hello")


@app.get("/")
def index():
    message = f"{MESSAGE_PREFIX}: {PrintHello()}"
    return jsonify({"service": APP_NAME, "message": message})


@app.get("/goodbye")
def goodbye():
    return jsonify({"service": APP_NAME, "message": PrintGoodbye()})


@app.get("/error")
def error():
    ErrorRandomly()
    return jsonify({"service": APP_NAME, "message": "No error"})


@app.get("/healthz")
def healthz():
    return "ok", 200


if __name__ == "__main__":
    port = int(os.getenv("PORT", "8080"))
    app.run(host="0.0.0.0", port=port)

"""Небольшое учебное Flask-приложение для демонстрации GitLab CI."""

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return "<h1>GitLab CI Example работает!</h1><p>lint -> test -> build</p>"


@app.route("/health")
def health():
    return jsonify(status="ok")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

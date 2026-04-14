from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return "<h1>IaC Web App работает! (Terraform + Ansible + Docker)</h1><p>Версия: 1.0</p>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

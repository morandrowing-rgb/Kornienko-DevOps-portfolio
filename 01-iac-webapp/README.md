# IaC Web-приложение (Terraform + Ansible + Docker)

### Что реализовано
- Terraform — создание ВМ в Yandex Cloud
- Ansible — конфигурация сервера и запуск Docker
- Docker + Flask-приложение
- GitLab CI/CD пайплайн

### Как запустить локально
```bash
# 1. Terraform (локально или в облаке)
cd terraform && terraform init && terraform apply

# 2. Ansible deploy
ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml
```

# DevOps — учебные проекты и стенды

Александр — системный администратор, развиваюсь в DevOps. Ищу junior/middle-позиции.

Это портфолио **учебных проектов и локальных стендов**, а не production-систем.
Каждый проект я разбирал и запускал локально, чтобы на практике понять инструмент:
как он ставится, где ломается и как проверить, что результат правда работает.

> Честная оговорка: приложения внутри — простые демонстрационные (Flask / nginx:alpine).
> Ценность проектов — в инфраструктурной части вокруг них: Terraform, Docker,
> Kubernetes, CI/CD, Ansible и observability.

## Технологии

Docker · Docker Compose · Terraform (Yandex Cloud) · Kubernetes (kind) · Helm ·
Ansible · GitLab CI · Jenkins · Grafana · Loki · Promtail · Prometheus ·
Elasticsearch · Nginx · Python · Linux

## Проекты

Порядок ниже — от самого содержательного к более простым.

| № | Проект | Что внутри | Ключевые инструменты |
|---|--------|------------|----------------------|
| 1 | [Observability-стек](./02-observability-stack) | Сбор и просмотр логов: Grafana + Loki + Promtail + Elasticsearch, дашборд и provisioning из кода | Grafana, Loki, Promtail, Elasticsearch, Docker Compose |
| 2 | [Kubernetes Pet-Shop](./03-k8s-pet-shop) | Микросервисные манифесты для kind: Deployments, Services, ConfigMap/Secret, Ingress, **Helm-чарт** | Kubernetes, Helm, kind, NGINX Ingress, GitLab CI |
| 3 | [IaC Web-приложение](./01-iac-webapp) | Полный цикл: Terraform создаёт VM, Ansible ставит Docker, GitLab CI собирает приложение | Terraform, **Ansible**, Docker, **GitLab CI** |
| 4 | [Bookstore DevOps](./05-bookstore-devops) | Terraform + Kubernetes-манифест + отдельный monitoring-compose (Prometheus/Grafana/Loki), Ansible-плейбук деплоя | Terraform, Kubernetes, Prometheus, Ansible, GitLab CI, Jenkins |
| 5 | [Multi-CI/CD](./04-multi-ci-cd) | Одно приложение — два пайплайна: Jenkins и GitLab CI, для сравнения подходов | Jenkins, GitLab CI, Docker |

В каждом проекте: README с инструкцией запуска, исходники/конфиги и скриншоты результата.

## Что хочу усилить дальше

- Добавить в этот репозиторий обезличенные скрипты из реальной практики
  (Bash/Python: бэкапы, автоматизация рутины) — сейчас они вынесены в отдельное
  портфолио системного администратора.
- Довести Helm-чарт проекта 03 до установки через `helm upgrade --install` на чистом kind.
- Заменить демонстрационные nginx-образы в проекте 03 на собственное приложение.

## Контакты

Контакты и резюме указаны в профиле на HeadHunter и в сопроводительных письмах к откликам.
<!-- TODO(владелец): при желании добавить сюда публичный контакт для связи. Не публикуйте личные данные, которыми не готовы делиться открыто. -->

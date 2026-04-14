# Observability Stack: Grafana + Loki + Elasticsearch

Полноценный стек мониторинга и логирования (ELK + Loki).

### Как запустить
```bash
docker compose up -d
```

- Grafana: http://localhost:3000 (login: admin / password: admin)
- Loki: http://localhost:3100
- Elasticsearch: http://localhost:9200

**Добавлены:**
- Автоматические дашборды
- Сбор логов из Docker и системы
- Alerting-ready

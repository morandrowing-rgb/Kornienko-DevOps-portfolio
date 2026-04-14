#  Pet-Shop Microservices на Kubernetes

### Технологии
- Kubernetes (Kind / Minikube)
- 4 микросервиса
- Helm-ready
- Terraform для кластера
- GitLab CI + Loki + Grafana

### Запуск
```bash
kind create cluster
kubectl apply -f k8s/
kubectl port-forward svc/frontend 8080:80
```

**Включает Grafana + Loki** — полный observability.

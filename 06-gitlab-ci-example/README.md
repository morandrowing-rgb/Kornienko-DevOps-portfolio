# 06 — GitLab CI Example

**Небольшой учебный проект**: простое Flask-приложение и настоящий
GitLab CI-пайплайн для него. Это не production и не деплой на сервер —
цель показать, как устроены стадии, кэш, артефакты и правила запуска.

## Что внутри

| Файл | Назначение |
|---|---|
| `app.py` | Flask-приложение: `/` — страница, `/health` — JSON `{"status": "ok"}` |
| `test_app.py` | Тесты на `unittest` + Flask `test_client` (сервер и сеть не нужны) |
| `requirements.txt` | Единственная зависимость — Flask |
| `Dockerfile` | Образ приложения на `python:3.12-slim` |
| `.gitlab-ci.yml` | Пайплайн: lint → test → build |

## Что делает пайплайн

1. **lint** (`python:3.12-slim`)
   - `python -m py_compile` — проверка, что код компилируется;
   - `flake8` — базовая проверка стиля (`--max-line-length=100`).
2. **test** (`python:3.12-slim`)
   - `pip install -r requirements.txt`;
   - `python -m unittest discover -v` — тесты `/` и `/health`;
   - лог тестов сохраняется как artifact (`test-output.txt`, 1 неделя).
3. **build** (`docker:24.0.7` + `docker:dind`)
   - `docker build` образа приложения;
   - `docker save` в `gitlab-ci-example.tar` — artifact на 3 дня.
   - Образ никуда не публикуется (нет `docker push`) — это осознанно.

Общие настройки:

- **Кэш pip**: `PIP_CACHE_DIR` + `cache:` с ключом по `requirements.txt`,
  чтобы повторные запуски не качали пакеты заново. У build-джобы кэш отключён
  (`cache: {}`) — ей pip не нужен.
- **`rules:` вместо устаревшего `only:`** — пайплайн запускается на
  merge request, ветки и теги; отдельные джобы дополнительно смотрят
  на `changes:` по своим файлам.
- **`workflow: rules:`** — единый вход, без дублей пайплайнов на MR и ветку.

## Как запустить

### Локально (без GitLab)

```bash
cd 06-gitlab-ci-example
python3 -m venv .venv && . .venv/bin/activate
pip install -r requirements.txt

python -m unittest discover -v   # тесты
python app.py                    # http://localhost:5000 и /health
```

### В GitLab

Папка самодостаточна: импортируйте именно её как отдельный GitLab-проект
(или укажите путь к этому `.gitlab-ci.yml` в настройках CI/CD репозитория),
запушьте в ветку — пайплайн стартует сам. На merge request сработают
lint и test, на основной ветке и тегах — ещё и build.

### Docker вручную

```bash
docker build -t gitlab-ci-example .
docker run --rm -p 5000:5000 gitlab-ci-example
curl http://localhost:5000/health
```

## Честные ограничения

- Нет деплоя: ни SSH, ни Kubernetes, ни registry push в пайплайне нет.
- Тесты покрывают только два маршрута учебного приложения.
- Версии образов и Flask зафиксированы для воспроизводимости, а не как
  рекомендация для боевых систем.

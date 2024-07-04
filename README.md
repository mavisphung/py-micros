# Python projects for demostration
This is a sample repository to demostrate about how Nginx, FastAPI and Docker will work together

## Prerequisite
1. Python ^3.12
2. [Poetry](https://python-poetry.org/docs/)
3. Docker

## How to run
```bash
# install dependencies
poetry install
```

```bash
# add new dependencies
poetry add <dependency>
```

```bash
# run book_service
fastapi dev book_service/main.py --port=8000

# run location_service
fastapi dev location_service/main.py --port=8001
```
## Docker
```bash
docker compose up -d --build
```


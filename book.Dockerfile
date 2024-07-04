# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:slim-bullseye as base

# Copy only requirements to cache them in docker layer
WORKDIR /app

ARG env

ENV ENVIRONMENT=${env} \
  PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  # Poetry's configuration:
  POETRY_NO_INTERACTION=1 \
  POETRY_VIRTUALENVS_CREATE=false \
  # Make sure to update POETRY_VERSION!
  POETRY_VERSION=1.8 

# System deps:
RUN pip install poetry==$POETRY_VERSION

COPY README.md poetry.lock pyproject.toml /app/

# Project initialization:
RUN poetry install $(test "$ENVIRONMENT" == production && echo "--only main") --no-interaction --no-ansi

# Creating folders, and files for a project:
COPY ./book_service /app/book_service

# RUN fastapi run location_service/main.py --port=9001

# proxy-headers is required for running behind a reverse proxy --proxy-headers
CMD ["fastapi", "run", "book_service/main.py", "--proxy-headers"]

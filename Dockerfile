# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:slim-bullseye as base

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


# Build stage
FROM base as builder

# Copy only requirements to cache them in docker layer
WORKDIR /app
COPY README.md poetry.lock pyproject.toml /app/

# Project initialization:
RUN poetry install $(test "$ENVIRONMENT" == production && echo "--only main") --no-interaction --no-ansi

# Creating folders, and files for a project:
COPY . /app


# development stage
FROM builder as book-service
WORKDIR /app

# proxy-headers is required for running behind a reverse proxy
CMD ["fastapi", "dev", "book_service/main.py", "--proxy-headers", "--port=9000"]
EXPOSE 9000

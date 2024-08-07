from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"location-service": "Hello, World!"}


@app.get("/locations/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}

@app.get("/health-check")
def do_health_check():
    return {"location-service-status": "ok"}

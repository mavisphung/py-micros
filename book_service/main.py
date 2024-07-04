from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"book-service": "Hello, World!"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}

@app.get("/health-check")
def do_health_check():
    return {"book-service-status": "ok"}

# if __name__ == "__main__":
#     import uvicorn
#     uvicorn.run(app, host="localhost", port=9000)

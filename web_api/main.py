import asyncio
from hypercorn.config import Config
from hypercorn.asyncio import serve

from fastapi import FastAPI

config = Config()
config.bind = ["0.0.0.0:8080"]
config.accesslog = "-"


app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/hello")
async def hello():
    return {"message": "hello world"}


def start():
    print("Starting application!")
    asyncio.run(serve(app,config))


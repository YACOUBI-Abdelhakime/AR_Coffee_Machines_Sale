from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
from typing import List
from datetime import datetime
import jwt

app = FastAPI()

SECRET_KEY = "mysecretkey"

class Customer(BaseModel):
    id: int
    name: str
    email: str
    phone_number: str
    address: str

class Order(BaseModel):
    id: int
    customer_id: int
    date: datetime
    items: List[str]
    total_price: float

customers = []
orders = []

def authenticate_user(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY)
        return payload["sub"]
    except (jwt.exceptions.ExpiredSignatureError, jwt.exceptions.InvalidTokenError):
        raise HTTPException(status_code=400, detail="Invalid token")

@app.get("/customers/{customer_id}")
async def read_customer(customer_id: int, token: str):
    authenticate_user(token)
    for customer in customers:
        if customer.id == customer_id:
            return customer
    return {"detail": {"error": "customer not found"}}, 404

@app.get("/customers/")
async def read_all_customers(token: str):
    authenticate_user(token)
    return customers

@app.post("/customers/")
async def create_customer(customer: Customer, token: str):
    authenticate_user(token)
    customer.id = len(customers) + 1
    customers.append(customer)
    return customer

@app.get("/customers/{customer_id}/orders")
async def read_customer_orders(customer_id: int, token: str):
    authenticate_user(token)
    customer_orders = [order for order in orders if order.customer_id == customer_id]
    return customer_orders

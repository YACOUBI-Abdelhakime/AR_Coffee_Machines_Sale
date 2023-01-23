from fastapi import FastAPI, HTTPException, Depends, Header
import jwt
from typing import List

app = FastAPI()

# Secret key for encoding and decoding JWT tokens
SECRET_KEY = "mysecretkey"

# Define the endpoint of the CRM's API
crm_endpoint = "https://crm.example.com/api/v1"

# Function for checking if the user has the correct role
def check_roles(role: str = Header(None)):
    if role not in ["admin", "user"]:
        raise HTTPException(status_code=400, detail="Invalid role")
    return role

# Function for decoding JWT tokens
def decode_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY)
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=400, detail="Invalid token")
    return payload

# Function for sending GET requests to the CRM's API
async def get_data_from_crm(path: str):
    url = crm_endpoint + path
    response = requests.get(url)
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.text)
    return response.json()

# Function for sending POST requests to the CRM's API
async def post_data_to_crm(path: str, data: dict):
    url = crm_endpoint + path
    response = requests.post(url, json=data)
    if response.status_code != 201:
        raise HTTPException(status_code=response.status_code, detail=response.text)
    return response.json()

# Function for sending PUT requests to the CRM's API
async def put_data_to_crm(path: str, data: dict):
    url = crm_endpoint + path
    response = requests.put(url, json=data)
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.text)
    return response.json()

# Function for sending DELETE requests to the CRM's API
async def delete_data_from_crm(path: str):
    url = crm_endpoint + path
    response = requests.delete(url)
    if response.status_code != 204:
        raise HTTPException(status_code=response.status_code, detail=response.text)
    return response.json()

# Define the routes for the API
@app.get("/customers/{customer_id}")
async def read_customer(customer_id: int, auth_token: str = Header(None)):
    # Decode the JWT token to get the user's role
    payload = decode_token(auth_token)
    user_role = payload["role"]
# Check if the user has the correct role
    if user_role != "admin":
        raise HTTPException(status_code=403, detail="Forbidden")
    # Retrieve the customer from the CRM
    customer = await get_data_from_crm(f"/customers/{customer_id}")
    if customer is None:
        raise HTTPException(status_code=404, detail="Customer not found")
    return customer
@app.post("/customers/")
async def create_customer(customer: dict, auth_token: str = Header(None), role: str = Depends(check_roles)):
    # Decode the JWT token to get the user's role
    payload = decode_token(auth_token)
    user_role = payload["role"]
    # Check if the user has the correct role
    if user_role != role:
        raise HTTPException(status_code=403, detail="Forbidden")
    # Create a new customer in the CRM
    new_customer = await post_data_to_crm("/customers/", customer)
    return {"id": new_customer["id"]}

@app.put("/customers/{customer_id}")
async def update_customer(customer_id: int, customer: dict, auth_token: str = Header(None)):
    # Decode the JWT token to get the user's role
    payload = decode_token(auth_token)
    user_role = payload["role"]
    # Check if the user has the correct role
    if user_role != "admin":
        raise HTTPException(status_code=403, detail="Forbidden")
    # Update the customer in the CRM
    await put_data_to_crm(f"/customers/{customer_id}", customer)
    return {"id": customer_id}

@app.delete("/customers/{customer_id}")
async def delete_customer(customer_id: int, auth_token: str = Header(None)):
    # Decode the JWT token to get the user's role
    payload = decode_token(auth_token)
    user_role = payload["role"]
    # Check if the user has the correct role
    if user_role != "admin":
        raise HTTPException(status_code=403, detail="Forbidden")
    # Delete the customer from the CRM
    await delete_data_from_crm(f"/customers/{customer_id}")
    return {"id": customer_id}


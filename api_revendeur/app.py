from fastapi import FastAPI, HTTPException
from typing import List
import requests

app = FastAPI()

# Define the endpoint of the ERP's API
erp_endpoint = "https://erp.example.com/api/v1"

# Function for sending GET requests to the ERP's API
async def get_data_from_erp(path: str):
    url = erp_endpoint + path
    response = requests.get(url)
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.text)
    return response.json()

# Function for sending POST requests to the ERP's API
async def post_data_to_erp(path: str, data: dict):
    url = erp_endpoint + path
    response = requests.post(url, json=data)
    if response.status_code != 201:
        raise HTTPException(status_code=response.status_code, detail=response.text)
    return response.json()

# Function for sending PUT requests to the ERP's API
async def put_data_to_erp(path: str, data: dict):
    url = erp_endpoint + path
    response = requests.put(url, json=data)
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.text)
    return response.json()

# Function for sending DELETE requests to the ERP's API
async def delete_data_from_erp(path: str):
    url = erp_endpoint + path
    response = requests.delete(url)
    if response.status_code != 204:
            raise HTTPException(status_code=response.status_code, detail=response.text)
    return response.json()

# Define the routes for the API
@app.get("/products/{product_id}")
async def read_product(product_id: int):
    # Retrieve the product from the ERP
    product = await get_data_from_erp(f"/products/{product_id}")
    if product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    return product

@app.post("/products/")
async def create_product(product: dict):
    # Create a new product in the ERP
    new_product = await post_data_to_erp("/products/", product)
    return {"id": new_product["id"]}

@app.put("/products/{product_id}")
async def update_product(product_id: int, product: dict):
    # Update the product in the ERP
    updated_product = await put_data_to_erp(f"/products/{product_id}", product)
    return {"id": updated_product["id"]}

@app.delete("/products/{product_id}")
async def delete_product(product_id: int):
    # Delete the product from the ERP
    await delete_data_from_erp(f"/products/{product_id}")
    return {"id": product_id}
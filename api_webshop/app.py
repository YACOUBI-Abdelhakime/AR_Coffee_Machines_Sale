from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class Product(BaseModel):
    id: int
    name: str
    description: str
    price: float

@app.get("/products/{product_id}")
async def read_product(product_id: int):
    # Retrieve the product from the database
    product = get_product_from_database(product_id)
    if product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    return product

@app.post("/products/")
async def create_product(product: Product, user: str = Depends(check_roles)):
    # Create a new product in the database
    new_product = create_product_in_database(product)
    return {"id": new_product.id}

@app.put("/products/{product_id}")
async def update_product(product_id: int, product: Product, user: str = Depends(check_roles)):
    # Update the product in the database
    update_product_in_database(product_id, product)
    return {"id": product_id}

@app.delete("/products/{product_id}")
async def delete_product(product_id: int, user: str = Depends(check_roles)):
    # Delete the product from the database
    delete_product_from_database(product_id)
    return {"id": product_id}

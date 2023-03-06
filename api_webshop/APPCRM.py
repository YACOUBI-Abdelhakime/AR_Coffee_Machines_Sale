from fastapi import FastAPI, HTTPException
import requests
import qrcode
import io
import base64
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.image import MIMEImage

app = FastAPI()

# Define the endpoint of the CRM's API
crm_endpoint = "https://615f5fb4f7254d0017068109.mockapi.io/api/v1"

def generate_qr_code(unique_id: str):
    # Generate QR code
    qr = qrcode.QRCode(version=1, box_size=10, border=5)
    qr.add_data(unique_id)
    qr.make(fit=True)
    qr_image = qr.make_image(fill_color="black", back_color="white")

    # Convert image to base64 string
    with io.BytesIO() as buffer:
        qr_image.save(buffer, format="PNG")
        qr_image_base64 = base64.b64encode(buffer.getvalue()).decode()

    return qr_image_base64

@app.get("/send_qr_code/{user_id}")
async def send_qr_code(user_id: str):
    # Retrieve user from CRM
    user = await get_data_from_crm(f"/users/{user_id}")
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # Generate QR code
    qr_code = generate_qr_code(user_id)

    # Send email with QR code
    sender_email = "tonkawapaye@gmail.com"
    sender_password = "0123456789$ABC$abd"
    receiver_email = user["email"]
    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = "Your QR code"
    text = MIMEText("Please use this QR code to authenticate in the mobile app.")
    message.attach(text)
    image = MIMEImage(base64.b64decode(qr_code))
    message.attach(image)
    with smtplib.SMTP("smtp.gmail.com", 587) as server:
        server.starttls()
        server.login(sender_email, sender_password)
        server.sendmail(sender_email, receiver_email, message.as_string())

    return {"message": "QR code sent successfully"}

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
async def read_customer(customer_id: int):
    # Retrieve the customer from the CRM
    customer = await get_data_from_crm(f"/customers/{customer_id}")
    if customer is None:
        raise HTTPException(status_code=404, detail="Customer not found")
    return customer

@app.post("/customers/")
async def create_customer(customer: dict):
    # Create a new customer in the CRM
    new_customer = await post_data_to_crm("/customers/", customer)
    return {"id": new_customer["id"]}

@app.put("/customers/{customer_id}")
async def update_customer(customer_id: int, customer: dict):
    # Update the customer in the CRM
    await put_data_to_crm(f"/customers/{customer_id}", customer)
    return {"id": customer_id}

@app.delete("/customers/{customer_id}")
async def delete_customer(customer_id: int):
    # Delete the customer from the CRM
    await delete_data_from_crm(f"/customers/{customer_id}")
    return {"id": customer_id}
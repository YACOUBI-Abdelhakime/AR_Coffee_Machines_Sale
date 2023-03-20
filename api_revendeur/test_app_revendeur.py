from fastapi.testclient import TestClient

from app import app

client = TestClient(app)



# Test GET product by ID
def test_read_product():
     response = client.get("/products/1")

     assert response.status_code == 200
     assert response.json() == {
    "createdAt": "2023-02-19T13:42:19.010Z",
    "name": "Rex Bailey",
    "details": {
        "price": "659.00",
        "description": "The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J",
        "color": "red"
    },
    "stock": 12059,
    "id": "1"
}
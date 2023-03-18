from fastapi.testclient import TestClient

from APPCRM import app

client = TestClient(app)

    
# Test GET customer by ID
def test_read_customer():
     response = client.get("/customers/3")
     assert response.status_code == 200
     assert response.json() == {
        "createdAt": "2023-02-20T04:16:24.968Z",
        "name": "EPSI c'est nul",
        "username": "pire.ecole",
        "firstName": "Alex",
        "lastName": "Benlhaj dehbi",
        "address": {
            "postalCode": "EPSI TQT",
            "city": "LILLE"
        },
        "profile": {
            "firstName": "JEAN",
            "lastName": "DUJARDIN"
        },
        "company": {
            "companyName": "MSPR"
        },
        "id": "3",
        "email": "email@test.com",
        "orders": [
        {
        "createdAt": "2023-02-20T00:49:24.786Z",
        "id": "53",
        "customerId": "3"
        }
        ]
    }

# # Test GET non-existent customer by ID
# def test_read_nonexistent_customer():
#     response = client.get("/customers/99")
#     assert response.status_code == 404
#     assert response.json() == {"detail": "Customer not found"}


# # Test PUT customer by ID
# def test_update_customer():
#     updated_customer = {
#         "name": "Jhon Doe",
#     }
#     response = client.put("/customers/"+str(test_id), json=updated_customer)
#     assert response.status_code == 200
#     assert response.json() == {"id": test_id}

# # Test DELETE customer by ID
# def test_delete_customer():
#     response = client.delete("/customers/1")
#     assert response.status_code == 200
#     assert response.json() == {"id": 1}

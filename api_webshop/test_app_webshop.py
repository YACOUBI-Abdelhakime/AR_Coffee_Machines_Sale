from fastapi.testclient import TestClient

from APPCRM import app

client = TestClient(app)

    
# Test GET customer by ID
def test_read_customer():
     response = client.get("/customers/99")
     assert response.status_code == 200
     assert response.json() == {
    "createdAt": "2023-02-20T06:57:35.643Z",
    "name": "Glenda Howe",
    "username": "Ulises62",
    "firstName": "UN PURE BG---",
    "lastName": "changer d'écol--",
    "address": {
        "postalCode": "67879",
        "city": "Baldwin Park"
    },
    "profile": {
        "firstName": "Terry",
        "lastName": "O'Conner"
    },
    "company": {
        "companyName": "Crona, Raynor and Quigley"
    },
    "id": "99",
    "email": "Email@aaaa.com",
    "orders": []
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

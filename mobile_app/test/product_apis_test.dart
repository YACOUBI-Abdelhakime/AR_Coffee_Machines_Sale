import 'package:arcore_test/apis/product_apis.dart';
import 'package:arcore_test/controllers/product_controller.dart';
import 'package:arcore_test/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test api get one product by incorrect id from server', () async {
    String productId = "id incorrect";
    Product? product;
    // Add to local storage
    product = await getOneProductApi(productId);
    expect(product, null);
  });

  test('Test api get one product by correct id from server', () async {
    String productId = "3";
    Product? product;
    // Add to local storage
    product = await getOneProductApi(productId);
    expect(product?.id, productId);
  });

  test('Test api get all products from server', () async {
    List<Product>? products;
    // Add to local storage
    products = await getAllProductsApi();
    bool result = (products?.length ?? 0) > 0;
    expect(result, true);
  });
}

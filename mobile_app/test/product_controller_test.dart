import 'package:arcore_test/controllers/product_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test controller get all products from server', () async {
    // Add to local storage
    await ProductController.getAllProducts();
    int listLength = ProductController.allProducts?.length ?? 0;
    bool result = listLength > 0;
    expect(result, true);
  });
}

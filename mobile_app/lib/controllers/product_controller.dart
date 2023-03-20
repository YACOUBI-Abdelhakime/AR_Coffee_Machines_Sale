import 'package:arcore_test/apis/product_apis.dart';
import 'package:arcore_test/models/product.dart';

class ProductController {
  Product? oneProduct;
  static List<Product>? allProducts;

  static Future<void> getAllProducts() async {
    allProducts = await getAllProductsApi();
  }
}

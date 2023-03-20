import 'package:arcore_test/componants/drawer.dart';
import 'package:arcore_test/componants/sneak_bar.dart';
import 'package:arcore_test/controllers/product_controller.dart';
import 'package:arcore_test/models/product.dart';
import 'package:arcore_test/views/login.dart';
import 'package:arcore_test/views/product_details.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  static int productIndex = 0;
  bool productsInitialized = false;
  bool showLoader = true;
  @override
  void initState() {
    super.initState();
  }

  Widget productCard(Product product, int index) {
    // id [1..10]
    int imgId = (int.parse(product.id!) % 10) + 1;
    String title = product.name ?? "";
    String price = "${product.price!.toInt()}";
    int descLength = 70;
    String description = (product.description ?? "").length > descLength
        ? "${(product.description ?? "").substring(0, descLength)}..."
        : (product.description ?? "");
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shadowColor: Colors.grey,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          productIndex = index;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ProductDetails()),
            navTest(true),
          );
        },
        child: Container(
          width: screenWidth * 0.45,
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.45,
                height: screenWidth * 0.45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/products/machine-$imgId.jpg"),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    product.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    "$price €",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  void initProductsList() async {
    if (!productsInitialized) {
      await ProductController.getAllProducts();
      setState(() {});
      productsInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    initProductsList();
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Produits"),
            backgroundColor: Color(0xFF6F35A5),
          ),
          drawer: NavDrawer(),
          body: Stack(
            children: [
              // center
              Align(
                alignment: Alignment.center,
                child: Image.asset("assets/images/center.png", width: 220),
              ),
              // Top left
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: 120,
                ),
              ),
              // Top right
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/images/scan_qr_top.png", width: 120),
              ),
              // bottom left
              Positioned(
                bottom: 0,
                left: 0,
                child:
                    Image.asset("assets/images/scan_qr_bottom.png", width: 100),
              ),
              // Bottom right
              Positioned(
                bottom: 0,
                right: 0,
                child:
                    Image.asset("assets/images/login_bottom.png", width: 120),
              ),
              // Show loader
              if (ProductController.allProducts?.isEmpty ?? true) ...[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: const CircularProgressIndicator(
                      color: Color(0xFF6F35A5),
                      strokeWidth: 8,
                    ),
                  ),
                ),
              ],
              SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      for (int index = 0;
                          index < (ProductController.allProducts ?? []).length;
                          index++)
                        productCard(
                            ProductController.allProducts![index], index)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

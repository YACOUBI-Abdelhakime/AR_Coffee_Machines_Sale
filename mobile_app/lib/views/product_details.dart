import 'dart:io';

import 'package:arcore_test/componants/drawer.dart';
import 'package:arcore_test/controllers/product_controller.dart';
import 'package:arcore_test/models/product.dart';
import 'package:arcore_test/views/ar_camera/ar_camera_android.dart';
import 'package:arcore_test/views/ar_camera/ar_camera_ios.dart';
import 'package:arcore_test/views/home.dart';
import 'package:arcore_test/views/login.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool productsInitialized = false;
  Product? product;

  @override
  void initState() {
    super.initState();
  }

  void initProduct() async {
    if (!productsInitialized) {
      product = ProductController.allProducts![HomeScreenState.productIndex];
      productsInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    initProduct();
    int imgId = (int.tryParse(product!.id!)! % 10) + 1;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Détails"),
          backgroundColor: Color(0xFF6F35A5),
        ),
        drawer: NavDrawer(),
        body: Container(
          color: Colors.white,
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
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
              Container(
                width: screenWidth,
                height: screenHeight,
                child: Column(children: [
                  // Image
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.4,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: screenWidth - 30,
                            height: screenHeight * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/products/machine-$imgId.jpg"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return Platform.isIOS
                                      ? IosArCamera()
                                      : AndroidArCamera();
                                }),
                                navTest(true),
                              );
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Color(0xFF6F35A5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(80),
                                ),
                              ),
                              child: const Icon(
                                Icons.view_in_ar,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        product?.name ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Price
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Text(
                        "${product!.price!.toInt()} €",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Description
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: Text(
                        product?.description ?? "",
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Stock
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Text(
                        "Stock ${product!.stock}",
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

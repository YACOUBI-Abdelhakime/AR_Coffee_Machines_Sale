import 'dart:convert';
import 'dart:io';
import 'package:arcore_test/componants/sneak_bar.dart';
import 'package:arcore_test/main.dart';
import 'package:arcore_test/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const url = '$baseUrl/products';

Future<Product?> getOneProductApi(String id) async {
  final response = await http.get(Uri.parse('$url/$id'));

  if (response.statusCode == HttpStatus.ok) {
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    final product = Product.fromJson(jsonData);
    return product;
  } else {
    //showSneakBar(context, message: "Server error !");
    return null;
  }
}

Future<List<Product>?> getAllProductsApi() async {
  final response = await http.get(Uri.parse('$url'));

  if (response.statusCode == HttpStatus.ok) {
    final body = json.decode(utf8.decode(response.bodyBytes));
    if (body != null) {
      List<Product> jsonProducts = [];
      body.forEach((e) {
        Product product = Product.fromJson(e);
        jsonProducts.add(product);
      });

      return jsonProducts;
    }
  } else {
    //showSneakBar(context, message: "Server error !");
  }
  return null;
}

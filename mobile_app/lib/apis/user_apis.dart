import 'dart:convert';
import 'dart:io';
import 'package:arcore_test/componants/sneak_bar.dart';
import 'package:arcore_test/main.dart';
import 'package:arcore_test/models/user.dart';
import 'package:arcore_test/views/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const url = '$baseUrl/customers';

Future<User?> updateUserApi(BuildContext? context, User user) async {
  final response = await http.put(
    Uri.parse('$url/${user.userId}'),
    body: user.toJson(),
  );

  if (response.statusCode == HttpStatus.ok) {
    if (context != null) {
      //await showSneakBar(context, message: "ok ok", color: Colors.green);
    }
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    final user = User.fromJson(jsonData);
    return user;
  } else {
    if (context != null) {
      await showSneakBar(
        context,
        message: "Error",
      );
    }
  }
  return null;
}

Future<User?> getUserDataApi(String userEmail) async {
  final response = await http.get(
    Uri.parse('$url'),
  );

  if (response.statusCode == HttpStatus.ok) {
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    for (dynamic resp in jsonData) {
      if (resp["email"] == userEmail) {
        User userTest = User.fromJson(resp);
        return userTest;
      }
    }
  }
  return null;
}

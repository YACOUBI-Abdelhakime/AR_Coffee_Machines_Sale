import 'package:arcore_test/apis/product_apis.dart';
import 'package:arcore_test/apis/user_apis.dart';
import 'package:arcore_test/controllers/local_storage.dart';
import 'package:arcore_test/models/product.dart';
import 'package:arcore_test/models/user.dart';
import 'package:arcore_test/views/login.dart';
import 'package:flutter/material.dart';

class UserController {
  User? user;

  static Future<void> updateUser(BuildContext? context, User user) async {
    User? userResponse = await updateUserApi(context, user);
    // Update user from local storage using server response
    await LocalStorageProvider.setObject(
        key: "firstName", value: user.firstName ?? "");
    await LocalStorageProvider.setObject(
        key: "lastName", value: user.lastName ?? "");
  }

  static Future<User?> getUserData() async {
    User? user = await getUserDataApi(UserEmail);
    if (user != null) {
      // Add his data to local storage
      LocalStorageProvider.setObject(
          key: "firstName", value: user.firstName ?? "");
      LocalStorageProvider.setObject(
          key: "lastName", value: user.lastName ?? "");
      LocalStorageProvider.setObject(key: "email", value: user.email ?? "");
      LocalStorageProvider.setObject(key: "userId", value: user.userId ?? "");
    }
    return user;
  }
}

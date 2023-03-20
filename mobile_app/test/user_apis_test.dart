import 'package:arcore_test/apis/user_apis.dart';
import 'package:arcore_test/controllers/local_storage.dart';
import 'package:arcore_test/controllers/product_controller.dart';
import 'package:arcore_test/controllers/user_controller.dart';
import 'package:arcore_test/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test api to update user with correct id', () async {
    User user = User(
        userId: "20",
        firstName: "FirstNameTest",
        lastName: "LastNameTest",
        email: "Email@gmail.com");
    User? userUPdated = await updateUserApi(null, user);

    expect(user.userId, userUPdated?.userId);
    expect(user.firstName, userUPdated?.firstName);
    expect(user.lastName, userUPdated?.lastName);
    expect(user.email, userUPdated?.email);
  });

  test('Test api to update user with incorrect id', () async {
    User user = User(
        userId: "dfgsdhf",
        firstName: "FirstNameTest",
        lastName: "LastNameTest",
        email: "Email.test@gmail.com");
    User? userUPdated = await updateUserApi(null, user);
    expect(userUPdated, null);
  });
}

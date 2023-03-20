import 'package:arcore_test/controllers/local_storage.dart';
import 'package:arcore_test/controllers/product_controller.dart';
import 'package:arcore_test/controllers/user_controller.dart';
import 'package:arcore_test/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test controller to update user', () async {
    User user = User(
        userId: "3",
        firstName: "FirstNameTest",
        lastName: "LastNameTest",
        email: "Email@test.fr");
    await UserController.updateUser(null, user);
    String? firstName = await LocalStorageProvider.getObject("firstName");
    String? lastName = await LocalStorageProvider.getObject("lastName");

    expect(firstName, user.firstName);
    expect(lastName, user.lastName);
  });
}

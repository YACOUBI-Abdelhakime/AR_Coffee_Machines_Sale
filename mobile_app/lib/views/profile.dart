import 'package:arcore_test/componants/drawer.dart';
import 'package:arcore_test/controllers/local_storage.dart';
import 'package:arcore_test/controllers/user_controller.dart';
import 'package:arcore_test/models/user.dart';
import 'package:arcore_test/shared/text_field_validators.dart';
import 'package:arcore_test/views/login.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isUpdateUserData = false;
  bool userInitialized = false;
  User? user;
  int userImgId = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? firstNameError;
  String? lastNameError;
  String? emailError;

  @override
  void initState() {
    super.initState();
  }

  void initUser({User? userData}) async {
    if (!userInitialized && userData == null) {
      // Initialize user from local storage
      String userId = await LocalStorageProvider.getObject("userId") ?? "";
      userImgId = (int.tryParse(userId)! % 3) + 1;
      String firstName =
          await LocalStorageProvider.getObject("firstName") ?? "";
      String lastName = await LocalStorageProvider.getObject("lastName") ?? "";
      String email = await LocalStorageProvider.getObject("email") ?? "";
      user = User(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
      setState(() {
        firstNameController.text = firstName;
        lastNameController.text = lastName;
        emailController.text = email;
      });

      userInitialized = true;
    } else if (userData != null) {
      setState(() {
        firstNameController.text = userData.firstName ?? "";
        lastNameController.text = userData.lastName ?? "";
      });
    }
  }

  void updateUser() async {
    User newUser = User(
      userId: user?.userId ?? "",
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: user?.email ?? "",
    );
    UserController.updateUser(context, newUser);
    initUser(userData: newUser);
  }

  @override
  Widget build(BuildContext context) {
    initUser();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          backgroundColor: Color(0xFF6F35A5),
        ),
        drawer: NavDrawer(),
        body: GestureDetector(
          onTap: () {
            // Unfocus text field
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // bottom left
                Positioned(
                  top: 0,
                  left: 0,
                  child:
                      Image.asset("assets/images/signup_top.png", width: 120),
                ),
                // Bottom right
                Positioned(
                  bottom: 0,
                  right: 0,
                  child:
                      Image.asset("assets/images/login_bottom.png", width: 120),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        // Image
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/users/user-$userImgId.jpg"),
                              fit: BoxFit.contain,
                            ),
                            borderRadius: BorderRadius.circular(500),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        // User data
                        Container(
                          width: screenWidth * 0.85,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // First name
                                Container(
                                  decoration: BoxDecoration(
                                    color: !isUpdateUserData
                                        ? Color(0xFFF1E6FF)
                                        : Color(0xFFFDE5EA),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: firstNameController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    readOnly: !isUpdateUserData,
                                    cursorColor: Color(0xFF6F35A5),
                                    validator: (value) {
                                      setState(() {
                                        firstNameError = nameValidate(value);
                                      });
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Prénom",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Color(0xFF6F35A5),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 16),
                                  child: Text(
                                    firstNameError ?? "",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Last name
                                Container(
                                  decoration: BoxDecoration(
                                    color: !isUpdateUserData
                                        ? Color(0xFFF1E6FF)
                                        : Color(0xFFFDE5EA),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: lastNameController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    readOnly: !isUpdateUserData,
                                    cursorColor: Color(0xFF6F35A5),
                                    validator: (value) {
                                      setState(() {
                                        lastNameError = nameValidate(value);
                                      });
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Nom",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Color(0xFF6F35A5),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 16),
                                  child: Text(
                                    lastNameError ?? "",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // user email
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF1E6FF),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    readOnly: true,
                                    cursorColor: Color(0xFF6F35A5),
                                    validator: (value) {
                                      setState(() {
                                        emailError = emailValidate(value);
                                      });
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: Color(0xFF6F35A5),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 16),
                                  child: Text(
                                    emailError ?? "",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Update button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isUpdateUserData) {
                                          // Send to server to update user data
                                          _formKey.currentState?.validate();
                                          if (firstNameError == null &&
                                              lastNameError == null) {
                                            // Send request to server
                                            updateUser();
                                            setState(() {
                                              isUpdateUserData =
                                                  !isUpdateUserData;
                                            });
                                          }
                                          // Unfocus text field
                                          FocusScope.of(context).unfocus();
                                        } else {
                                          // Start update user data
                                          // Unfocus text field
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            isUpdateUserData =
                                                !isUpdateUserData;
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          color: !isUpdateUserData
                                              ? Color(0xFF6F35A5)
                                              : Color(0xFFFF7081),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          isUpdateUserData
                                              ? "Sauvgarder"
                                              : "Modifier",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    if (isUpdateUserData) ...[
                                      GestureDetector(
                                        onTap: () {
                                          // Unfocus text field and init user
                                          FocusScope.of(context).unfocus();
                                          initUser(userData: user);
                                          setState(() {
                                            isUpdateUserData = false;
                                          });
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 46,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(25),
                                            ),
                                            border: Border.all(
                                              color: Color(0xFF6F35A5),
                                              width: 2,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Annuler",
                                            style: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 35),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

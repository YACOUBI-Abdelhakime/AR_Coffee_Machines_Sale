// ignore_for_file: use_build_context_synchronously

import 'package:arcore_test/componants/alert_dialog.dart';
import 'package:arcore_test/componants/sneak_bar.dart';
import 'package:arcore_test/controllers/local_storage.dart';
import 'package:arcore_test/shared/text_field_validators.dart';
import 'package:arcore_test/views/home.dart';
import 'package:arcore_test/views/qr_code_scanner.dart';
import 'package:arcore_test/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

double screenWidth = 0;
double screenHeight = 0;
String UserEmail = "";
String LoginToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiZXhwIjoxNjk5NDEyMzEyLCJpYXQiOjE2MTk0MTIzMTJ9.uu1_GrQyQBgun7GEcDuX3ABO0QyyLw9wml7ILf99-hM";

/// Make quitePage to false to execute onWillPop function before quitting page
bool Function(Route<dynamic>) navTest(bool quitePage) {
  return (Route<dynamic> x) {
    return quitePage;
  };
}

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String? textFieldError;
  bool userLoginChecked = false;
  bool showLoader = true;

  @override
  void initState() {
    super.initState();
  }

  void checkIfAlreadySingedInAndTokenValid() async {
    if (!this.userLoginChecked) {
      setState(() {
        showLoader = true;
      });
      String userId = await LocalStorageProvider.getObject("userId") ?? "";
      String firstName =
          await LocalStorageProvider.getObject("firstName") ?? "";
      String lastName = await LocalStorageProvider.getObject("lastName") ?? "";
      String email = await LocalStorageProvider.getObject("email") ?? "";
      String token = await LocalStorageProvider.getObject("token") ?? "";
      if (userId.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          token.isNotEmpty) {
        bool tokenExpired = JwtDecoder.isExpired(token);
        if (!tokenExpired) {
          // User already signed in and token is valid navigate to home page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            navTest(false),
          );
        }
      }

      setState(() {
        showLoader = false;
      });
      this.userLoginChecked = true;
    }
  }

  Future<void> loginFunction() async {
    _formKey.currentState?.validate();
    if (textFieldError == null) {
      setState(() {
        showLoader = true;
      });
      // Send login request to server
      //TODO : LoginToken = Request response login

      // TODO: show error message if request send error
      if (this.emailController.text == "email@error.com") {
        await Future.delayed(const Duration(milliseconds: 1500));
        showAlertDialog(context, message: "Email incorrect");
      } else {
        // if all is ok navigate to home
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => QrCodeScannerScreen()),
          navTest(true),
        );
        UserEmail = this.emailController.text;
      }
      setState(() {
        showLoader = false;
      });
    }
    // Unfocus text field
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    checkIfAlreadySingedInAndTokenValid();
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              // Unfocus text field
              FocusScope.of(context).unfocus();
            },
            child: Container(
              width: screenWidth,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/main_top.png",
                      width: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset("assets/images/login_bottom.png",
                        width: 120),
                  ),
                  SafeArea(
                      child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Page title
                        const Text(
                          "Connectez vous",
                          style: TextStyle(
                            color: Color(0xFF6F35A5),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // SVG image
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 8,
                              child: SvgPicture.asset("assets/icons/login.svg"),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 8,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    // Text Field widget
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF1E6FF),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: emailController,
                                        readOnly: showLoader,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: Color(0xFF6F35A5),
                                        validator: (value) {
                                          setState(() {
                                            textFieldError =
                                                emailValidate(value);
                                          });
                                          return null;
                                        },
                                        onSaved: (email) {},
                                        decoration: const InputDecoration(
                                          hintText: "email",
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
                                        textFieldError ?? "",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    if (!showLoader) ...[
                                      GestureDetector(
                                        onTap: loginFunction,
                                        child: Container(
                                          width: 150,
                                          height: 46,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF6F35A5),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(25),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "Se connecter",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ] else ...[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        child: const CircularProgressIndicator(
                                          color: Color(0xFF6F35A5),
                                          strokeWidth: 4,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 16),
                                    // Switch to singup
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text(
                                          "Vous n'avez pas de compte ? ",
                                          style: TextStyle(
                                              color: Color(0xFF6F35A5)),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUpScreen()),
                                              navTest(true),
                                            );
                                            // Unfocus text field
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: const Text(
                                            "S'inscrire",
                                            style: TextStyle(
                                              color: Color(0xFF6F35A5),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

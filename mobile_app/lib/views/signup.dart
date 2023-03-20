import 'package:arcore_test/shared/text_field_validators.dart';
import 'package:arcore_test/views/home.dart';
import 'package:arcore_test/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

double screenWidth = 0;
double screenHeight = 0;

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
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
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/signup_top.png",
                    width: 120,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset("assets/images/signup_bottom.png",
                      width: 120),
                ),
                SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Page title
                      const Text(
                        "Inscrivez vous",
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
                            child: SvgPicture.asset(
                              "assets/icons/signup.svg",
                            ),
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
                                  // First name
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFDE5EA),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: firstNameController,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: Color(0xFF6F35A5),
                                      validator: (value) {
                                        setState(() {
                                          firstNameError = nameValidate(value);
                                        });
                                        return null;
                                      },
                                      onSaved: (email) {},
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
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFDE5EA),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: lastNameController,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: Color(0xFF6F35A5),
                                      validator: (value) {
                                        setState(() {
                                          lastNameError = nameValidate(value);
                                        });
                                        return null;
                                      },
                                      onSaved: (email) {},
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
                                      color: Color(0xFFFDE5EA),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: Color(0xFF6F35A5),
                                      validator: (value) {
                                        setState(() {
                                          emailError = emailValidate(value);
                                        });
                                        return null;
                                      },
                                      onSaved: (email) {},
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
                                  GestureDetector(
                                    onTap: () {
                                      _formKey.currentState?.validate();
                                      if (firstNameError == null &&
                                          lastNameError == null &&
                                          emailError == null) {
                                        // Send signup request to server

                                        // Navigate to scan qr code page
                                      } else {
                                        // TODO : Remove that
                                        // Navigate to home page
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                          navTest(true),
                                        );
                                      }
                                      // Unfocus text field
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 46,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFF7081),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "S'inscrire",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Switch to singup
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "Vous avez déjà un compte ? ",
                                        style:
                                            TextStyle(color: Color(0xFF6F35A5)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigate to login screen
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()),
                                            navTest(false),
                                          );
                                          // Unfocus text field
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: const Text(
                                          "Se connectez",
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
    );
  }
}

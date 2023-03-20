import 'package:arcore_test/apis/user_apis.dart';
import 'package:arcore_test/controllers/user_controller.dart';
import 'package:arcore_test/models/user.dart';
import 'package:arcore_test/views/qr_camera.dart';
import 'package:arcore_test/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

double screenWidth = 0;
double screenHeight = 0;

class QrCodeScannerScreen extends StatefulWidget {
  @override
  QrCodeScannerScreenState createState() => QrCodeScannerScreenState();
}

class QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  String? textFieldError;

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
            height: MediaQuery.of(context).size.height,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
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
                  child:
                      Image.asset("assets/images/scan_qr_top.png", width: 120),
                ),
                // bottom left
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset("assets/images/scan_qr_bottom.png",
                      width: 100),
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
                    children: <Widget>[
                      // Page title
                      const Text(
                        "Scanner le QR Code",
                        style: TextStyle(
                          color: Color(0xFF6F35A5),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Scannez le QR Code que vous avez reçu par e-mail pour vous connecter",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6F35A5),
                          fontSize: 14,
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
                            child: SvgPicture.asset("assets/icons/scan_qr.svg"),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          QRCameraState.checkingFinished = false;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const QRCamera(),
                          ));
                        },
                        child: Container(
                          width: 220,
                          height: 46,
                          decoration: const BoxDecoration(
                            color: Color(0xFF6F35A5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Scanner le QR Code",
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
                            "Vous n'avez pas reçu l'e-mail ? ",
                            style: TextStyle(color: Color(0xFF6F35A5)),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to login screen
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                navTest(false),
                              );
                              // Unfocus text field
                              FocusScope.of(context).unfocus();
                            },
                            child: const Text(
                              "Se reconnecter",
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
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

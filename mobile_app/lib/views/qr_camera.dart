import 'dart:developer';
import 'dart:io';
import 'package:arcore_test/componants/sneak_bar.dart';
import 'package:arcore_test/controllers/local_storage.dart';
import 'package:arcore_test/controllers/user_controller.dart';
import 'package:arcore_test/models/user.dart';
import 'package:arcore_test/views/home.dart';
import 'package:arcore_test/views/login.dart';
import 'package:arcore_test/views/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

/// Return  to page scan qr
/// remove sneakbar error

class QRCamera extends StatefulWidget {
  const QRCamera({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => QRCameraState();
}

class QRCameraState extends State<QRCamera> {
  static bool checkingFinished = false;
  // Login function
  void checkLoginQRcode(BuildContext context, String? QRcodeData) async {
    if (!checkingFinished) {
      // TODO : Check qr code data if is it valid ?
      if (LoginToken.isEmpty || QRcodeData != LoginToken) {
        // ignore: use_build_context_synchronously
        await showSneakBar(context, message: "QR Code invalide");
        checkingFinished = true;
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => QrCodeScannerScreen()),
          navTest(true),
        );
      } else {
        showSneakBar(context, message: "Connexion...", color: Colors.green);
        // If the token is good when add it to locale storage
        LocalStorageProvider.setObject(key: "token", value: QRcodeData ?? "");
        // Get and save user data lo local storage
        User? u = await UserController.getUserData();
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          navTest(false),
        );
      }
      checkingFinished = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRCodeDartScanView(
        typeScan: TypeScan.live,
        onCapture: (Result result) {
          checkLoginQRcode(context, result.text);
        },
      ),
    );
  }
}

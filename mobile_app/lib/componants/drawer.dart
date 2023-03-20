import 'package:arcore_test/controllers/local_storage.dart';
import 'package:arcore_test/views/home.dart';
import 'package:arcore_test/views/login.dart';
import 'package:arcore_test/views/profile.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          // center
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(bottom: 150),
                child: Image.asset("assets/images/center.png", width: 170)),
          ),
          // bottom left
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("assets/images/scan_qr_bottom.png", width: 100),
          ),
          // Bottom right
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/login_bottom.png", width: 120),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    opacity: 0.5,
                    image: AssetImage('assets/images/beans.jpg'),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.category_outlined),
                title: Text('Produits'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    navTest(false),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt_outlined),
                title: Text('Commandes'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text('Profile'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                    navTest(true),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Se deconnecter'),
                onTap: () {
                  // Remove all data from local storage
                  LocalStorageProvider.setObject(key: "firstName", value: "");
                  LocalStorageProvider.setObject(key: "lastName", value: "");
                  LocalStorageProvider.setObject(key: "email", value: "");
                  LocalStorageProvider.setObject(key: "userId", value: "");
                  LocalStorageProvider.setObject(key: "token", value: "");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    navTest(false),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

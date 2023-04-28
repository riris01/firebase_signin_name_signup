import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_login_practice/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main.dart';
import 'market_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _logout();
    _auth();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _auth() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.off(() => const LoginPage());
      } else {
        Get.off(() => const MarketPage());
      }
    });
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

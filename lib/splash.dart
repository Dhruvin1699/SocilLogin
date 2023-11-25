import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add your splash screen logic here
    // You can use a timer to navigate to the sign-in page after a certain duration
    Future.delayed(Duration(seconds: 2), () {
      Get.offNamed('/signin'); // Navigate to the sign-in page
    });

    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
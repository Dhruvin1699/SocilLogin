import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_yummy/signin.dart';
import 'package:firebase_yummy/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
 );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/signin', page: () => SignInPage()),
        // GetPage(name: '/signup', page: () => SignUpPage()),
      ],
    );
  }

}
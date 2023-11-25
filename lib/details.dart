import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'signin_controller.dart';
class DetailsPage extends StatelessWidget {
  final SignInController signInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Page'),

      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            signInController.signOut();
          },
          child: Text(
            'Sign Out',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

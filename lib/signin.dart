
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_yummy/details.dart';
import 'package:firebase_yummy/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignInPage extends StatelessWidget {
  final SignInController signInController = Get.put(SignInController());
  // final SignInController signInController = SignInController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign In',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: signInController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: signInController.passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Add Forgot Password logic here
                },
                child: Text('Forgot Password?'),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: signInController.signIn,
                  child: Text('Sign In'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [


                Container(
                  width: 150,
                  child: TextButton(
                    onPressed: signInController.signInWithGoogle,

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: Text(
                      'Google',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 150,
                  child: TextButton(
                    onPressed: () async {
                      // Add Facebook login logic here
                      UserCredential? userCredential = await signInController.signInWithFacebook();
                      if (userCredential != null) {
                        // Facebook sign-in successful, do something
                        print("Facebook Sign-In successful during sign-up: ${userCredential.user!.displayName}");
                        Get.to(DetailsPage());
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: Text(
                      'Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('Don\'t have an account? Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
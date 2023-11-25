import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_yummy/signin.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //
  // void onInit() async {
  //   // Initialize Firebase here
  //   await Firebase.initializeApp();
  //   super.onInit();
  // }
  void onInit() async {
    // Check if Firebase is initialized


    super.onInit();
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      // Continue with Google Sign In
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null; // Google sign-in cancelled
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in with Firebase
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Print user information
      print("Google Sign-In successful: ${userCredential.user!.displayName}");
      print("User UID: ${userCredential.user!.uid}");
      print("User email: ${userCredential.user!.email}");

      return userCredential;
    } catch (error) {
      print("Google sign-in error: $error");
      return null;
    }
  }
  // Future<void> signInWithGoogle() async {
  //   int res = 0;
  //   try {
  //     final GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();
  //
  //     final GoogleSignInAuthentication? googleAuth =
  //     await googleSignIn?.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     print(credential);
  //
  //     UserCredential userCredential =
  //     await _auth.signInWithCredential(credential);
  //
  //     //store data in firestore
  //     User? user = userCredential.user;
  //     print("data::::::::::::::::::::::::::::::;;${user!.displayName}");
  //     print("data::::::::::::::::::::::::::::::;;${user!.uid}");
  //     print("data::::::::::::::::::::::::::::::;;${user!.email}");
  //     if (user != null) {
  //       if (userCredential.additionalUserInfo!.isNewUser) {
  //         // await _firestore.collection('users').doc(user.uid).set(
  //         //   {
  //         //     'username': user.displayName,
  //         //     'uid': user.uid,
  //         //     'profilePhoto': user.photoURL,
  //         //     'phonenumber': user.phoneNumber,
  //         //     'email': user.email,
  //         //   },
  //         // );
  //         //if new user create than return true but already user exist than no need to store data so return true and true means auth is successfully done.
  //         res = 2;
  //       } else {
  //         res = 1;
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // Utility.snackBar(e.message!, Get.context!);
  //     print("error::::::::::::::::::::::::${e.message}");
  //     res = 0;
  //   }
  //   // return res;
  // }
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the Facebook Sign In process
      final result = await FacebookAuth.instance.login();

      // Check if the Facebook sign-in process was successful
      if (result.status == LoginStatus.success) {
        // Get Facebook access token
        final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);

        // Sign in with Firebase
        UserCredential userCredential = await _auth.signInWithCredential(credential);

        // Print user information
        print("Facebook Sign-In successful: ${userCredential.user!.displayName}");
        print("User UID: ${userCredential.user!.uid}");
        print("User email: ${userCredential.user!.email}");

        return userCredential;
      } else {
        // Handle Facebook sign-in cancellation or error
        print("Facebook Sign-In cancelled or failed.");
        return null;
      }
    } catch (error) {
      print("Facebook sign-in error: $error");
      return null;
    }
  }


  void signIn() async {
    // Google Sign-In
    // UserCredential? googleUserCredential = await signInWithGoogle();
    // if (googleUserCredential != null) {
    //   // Google sign-in successful, print information
    //   print("Google Sign-In successful: ${googleUserCredential.user!.displayName}");
    // } else {
    //   // Handle Google sign-in cancellation or error
    //   print("Google Sign-In cancelled or failed.");
    // }

    // Facebook Sign-In
    // UserCredential? facebookUserCredential = await signInWithFacebook();
    // if (facebookUserCredential != null) {
    //   // Facebook sign-in successful, print information
    //   print("Facebook Sign-In successful: ${facebookUserCredential.user!.displayName}");
    // } else {
    //   // Handle Facebook sign-in cancellation or error
    //   print("Facebook Sign-In cancelled or failed.");
    // }
  }
  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Redirect to the sign-in page or any other page after sign out
      Get.offAll(SignInPage());
    } catch (e) {
      print("Sign out error: $e");
    }
  }
  // void signinWithFacebook() async {
  //   UserCredential? userCredential = await signInWithFacebook();
  //   if (userCredential != null) {
  //     // Facebook sign-in successful, do something
  //     print("Facebook Sign-In successful: ${userCredential.user!.displayName}");
  //   } else {
  //     // Handle Facebook sign-in cancellation or error
  //     print("Facebook Sign-In cancelled or failed.");
  //   }
  // }

  // void navigateToSignUp() {
  //   Get.to(SignUpPage());
  // }
}

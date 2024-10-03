// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_screen/sign_up_screen.dart';
import 'controller/login_controller.dart';

class AuthCubit {

  static SocialController socialController = Get.put(SocialController());

 static Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {

        socialController.socialloginApi(email: userCredential.user!.email.toString());

      }
    } catch(e) {
      print(e.toString());
    }
  }

 static Future<void> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      if (userCredential.user != null) {

        if (userCredential.user != null) {
          Get.to( Sign_Up(social: true,socialemail: userCredential.user!.email.toString(),));
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }


// Logout code

// await GoogleSignIn().signOut();

}



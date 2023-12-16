import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:speedo/view/onboarding.dart';
import 'package:speedo/view/profile.dart';

import '../Service/map.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const MapPage();
          } else {
            return const WelcomeScreen();
          }
        });
  }

  signInWithGoogle(BuildContext context) async {
    SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);
    dialog.show(
        message: 'Loading', type: SimpleFontelicoProgressDialogType.threelines);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Redirect the user
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? firebaseUser = userCredential.user;

    dialog.hide();
    if (firebaseUser != null) {
      final bool isNewUser =
          userCredential.additionalUserInfo?.isNewUser ?? false;

      if (isNewUser) {
        Get.offAll(() => const Profile());
      } else {
        Get.offAll(() => const MapPage());
      }
    } else {
      // Handle authentication error
      debugPrint('Error authenticating user');
    }
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const WelcomeScreen());
    } catch (e) {
      debugPrint('Error signing out: $e');
      Get.snackbar(
        "Error",
        "Failed to sign out. Please try again.",
        backgroundColor: Colors.transparent,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        colorText: Colors.red,
        borderWidth: 1,
        borderColor: Colors.red,
      );
    }
  }
}

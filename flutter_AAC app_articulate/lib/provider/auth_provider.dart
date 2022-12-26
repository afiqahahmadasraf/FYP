//Afiqah SUKD1802300
//Methods for google sign in

import 'package:articulate/firebase_refs/references.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
    await saveUser(googleUser);
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "userID": account.id,
      "email": account.email,
      "name": account.displayName,
      "profilePic": account.photoUrl
    });
  }
}

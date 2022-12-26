//Afiqah SUKD1802300
//UI for account screen

// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:articulate/services/utils.dart';
import 'package:articulate/ui/auth/login_screen.dart';
import 'package:articulate/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({super.key});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: Colors.white),
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                RotatedBox(
                  quarterTurns: 4,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        alignment: Alignment.topLeft,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_rounded)),
                  ),
                ),
                Text(
                  'Account',
                  style: GoogleFonts.playfairDisplay(
                    textStyle:
                        const TextStyle(fontSize: 20, color: Colors.black),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text("Email",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.playfairDisplay(
                        textStyle:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      )),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(user.email!,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.playfairDisplay(
                        textStyle:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      )),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Text("Reset Password",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.playfairDisplay(
                        textStyle:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      )),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                      onTap: () {
                        verifyEmail();
                      },
                      child: Text(
                        "Tap to reset your password",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                              color: Colors.blue),
                        ),
                      )),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    // Within the `FirstRoute` widget
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SignInScreen(
                                    onClickedSignUp: () {},
                                  )),
                          (route) => false);
                    },
                    child: Text(
                      'SIGN OUT',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ))),
      )),
    );
  }

  Future verifyEmail() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: Loading()));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);

      Utils.showSnackBarGreen(
          "An email to reset your password has been sent, please check your inbox or spam folder.");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}

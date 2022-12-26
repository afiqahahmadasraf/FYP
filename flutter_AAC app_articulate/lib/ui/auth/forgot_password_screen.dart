//Afiqah SUKD1802300
//UI for forgot password

// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:articulate/services/utils.dart';
import 'package:articulate/widgets/loading_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_rounded)),
                      ],
                    ),
                    Text(
                      'Forgot your password?',
                      style: GoogleFonts.openSans(
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "An email will be sent to you to reset your password",
                      style: GoogleFonts.openSans(
                        textStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: Text("Email",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          )),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your email address',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter a valid email address'
                              : null,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent[100],
                        ),
                        // Within the `FirstRoute` widget
                        onPressed: verifyEmail,
                        child: Text(
                          'SUBMIT',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )));
  }

  Future verifyEmail() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: Loading()));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

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

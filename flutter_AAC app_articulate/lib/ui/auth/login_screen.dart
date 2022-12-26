//Afiqah SUKD1802300
//UI for login screen

// ignore_for_file: avoid_print

import 'package:articulate/main.dart';
import 'package:articulate/services/utils.dart';
import 'package:articulate/ui/auth/forgot_password_screen.dart';
import 'package:articulate/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignInScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  'Sign In',
                  style: GoogleFonts.openSans(
                    textStyle:
                        const TextStyle(fontSize: 23, color: Colors.black),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Text("Email",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.openSans(
                        textStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Text("Password",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.openSans(
                        textStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.openSans(
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen())),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent[100],
                    ),
                    onPressed: signIn,
                    child: Text(
                      'SIGN IN',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: widget.onClickedSignUp,
                    child: Text(
                      'REGISTER A NEW ACCOUNT',
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
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: Loading()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    //if Navigator.of(context) is not working,
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

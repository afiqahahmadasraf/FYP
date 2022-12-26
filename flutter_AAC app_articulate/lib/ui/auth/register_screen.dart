//Afiqah SUKD1802300
//UI for register screen

// ignore_for_file: avoid_print

import 'package:articulate/main.dart';
import 'package:articulate/services/database_services.dart';
import 'package:articulate/services/utils.dart';
import 'package:articulate/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpScreen({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(
                    'Register with Articulate',
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
                          textStyle: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your email',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email address'
                            : null,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Text("Password",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your password',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? "Enter a min. of 6 characters"
                        : null,
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
                      // Within the `FirstRoute` widget
                      onPressed: signUp,
                      child: Text(
                        'SIGN UP',
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
                      onPressed: widget.onClickedSignIn,
                      child: Text(
                        'SIGN IN TO YOUR ACCOUNT',
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
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: Loading()));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      //create collections for new user
      final User user = auth.currentUser!;
      await DatabaseService(uid: user.uid).createUserData('yes');
      await DatabaseService(uid: user.uid).createTiles('Create your own tile!',
          'https://firebasestorage.googleapis.com/v0/b/articulate-aac-2022.appspot.com/o/logo.png?alt=media&token=7fc40752-c2a9-4bc2-aafc-e9c5d3972162');

      FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set({"email": user.email, "name": user.displayName});
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    //if Navigator.of(context) is not working,
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

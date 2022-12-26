//Afiqah SUKD1802300
//Toggle between sign up and sign in screen

import 'package:articulate/ui/auth/login_screen.dart';
import 'package:articulate/ui/auth/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      isLogin ? SignInScreen(onClickedSignUp: toggle) 
      : SignUpScreen(onClickedSignIn: toggle);

      void toggle() =>setState(() {
        isLogin = !isLogin;
      });
}

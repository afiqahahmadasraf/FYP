//Afiqah SUKD1802300
//This file is the main file that needs to be run

// ignore_for_file: depend_on_referenced_packages

import 'package:articulate/authenticate/authenticate.dart';
import 'package:articulate/firebase_options.dart';
import 'package:articulate/services/utils.dart';
import 'package:articulate/ui/home/home_screen_ms.dart';
import 'package:articulate/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

/* Upload Json files to Firestore */
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(GetMaterialApp(home: DataUploaderScreen()));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const FirstScreen(),
      //signin
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Loading());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong!'));
              } else if (snapshot.hasData) {
                return const HomeScreenMs();
              } else {
                return const AuthScreen();
              }
            }),
      );
}

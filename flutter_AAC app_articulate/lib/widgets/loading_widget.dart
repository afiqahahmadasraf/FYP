//Afiqah SUKD1802300
//Reusable loading widget

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitWave(
          color: Colors.blue.shade400,
          size: 50.0,
        ),
      ),
    );
  }
}

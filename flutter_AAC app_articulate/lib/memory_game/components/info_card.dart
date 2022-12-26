//Afiqah SUKD1802300
//UI for points and tap card for memory game

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget info_card(String title, String info) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(26.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade200,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            info,
            style: const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

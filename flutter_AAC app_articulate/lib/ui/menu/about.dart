// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class AboutArticulate extends StatelessWidget {
  const AboutArticulate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: const Text('Back'),
        icon: const Icon(Icons.arrow_back),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: const Color.fromRGBO(203, 223, 250, 1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      child: Image.asset("assets/manual/1.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Image.asset("assets/manual/2.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Image.asset("assets/manual/3.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Image.asset("assets/manual/4.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Image.asset("assets/manual/5.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Image.asset("assets/manual/6.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Image.asset("assets/manual/7.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Image.asset("assets/manual/8.png"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

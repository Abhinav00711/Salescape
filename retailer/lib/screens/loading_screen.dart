import 'package:flutter/material.dart';

import 'package:rive/rive.dart' as rive;

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.teal, Colors.tealAccent])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: rive.RiveAnimation.asset(
            'assets/animations/loader.riv',
            animations: const ['End glow', 'Main loop'],
          ),
        ),
      ),
    );
  }
}

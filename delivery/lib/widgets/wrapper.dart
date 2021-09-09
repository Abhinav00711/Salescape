import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../providers/auth_provider.dart';
import '../screens/error_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthProvider().user,
      builder: (context, user) {
        if (user.hasError) {
          return ErrorScreen();
        } else if (user.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

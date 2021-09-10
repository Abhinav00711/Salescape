import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/verify_screen.dart';
import '../screens/error_screen.dart';
import '../screens/loading_screen.dart';
import '../providers/auth_provider.dart';
import '../services/firestore_service.dart';
import '../models/delivery.dart';
import '../data/global.dart';

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
          return FutureBuilder<bool>(
            future:
                Provider.of<AuthProvider>(context, listen: false).isVerified(),
            builder: (context, verify) {
              if (verify.hasError) {
                return ErrorScreen();
              } else if (verify.hasData) {
                if (verify.data!) {
                  return FutureBuilder<Delivery?>(
                    future: FirestoreService().getUser(user.data!.uid),
                    builder: (context, userData) {
                      if (userData.hasError) {
                        return ErrorScreen();
                      } else if (userData.hasData) {
                        Global.userData = userData.data;
                        return HomeScreen();
                      } else {
                        return LoadingScreen();
                      }
                    },
                  );
                } else {
                  user.data!.sendEmailVerification();
                  return VerifyScreen();
                }
              } else {
                return LoadingScreen();
              }
            },
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './widgets/wrapper.dart';
import './widgets/my_material_app.dart';
import './screens/error_screen.dart';
import './screens/loading_screen.dart';
import './providers/auth_provider.dart';
import './providers/cart_provider.dart';
import './providers/filter_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MyMaterialApp(ErrorScreen());
        } else if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
              ChangeNotifierProvider<CartProvider>.value(value: CartProvider()),
              ChangeNotifierProvider<FilterProvider>.value(
                  value: FilterProvider()),
            ],
            child: MyMaterialApp(Wrapper()),
          );
        } else {
          return MyMaterialApp(LoadingScreen());
        }
      },
    );
  }
}

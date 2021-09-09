import 'package:flutter/material.dart';

class MyMaterialApp extends StatelessWidget {
  final Widget home;
  const MyMaterialApp(this.home);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salescape',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        platform: TargetPlatform.android,
      ),
      home: home,
    );
  }
}

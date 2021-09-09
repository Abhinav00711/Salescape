import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:animations/animations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/LoginScreen/sign_up.dart';
import '../widgets/LoginScreen/sign_in.dart';
import '../widgets/LoginScreen/background_painter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFirstBack = true;

  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    return WillPopScope(
      onWillPop: () async {
        if (_isFirstBack) {
          Fluttertoast.showToast(
              msg: "Press again to exit",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          _isFirstBack = false;
          await Future.delayed(Duration(seconds: 1))
              .then((_) => _isFirstBack = true);
        } else {
          return true;
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: BackgroundPainter(
                    animation: _controller,
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: showSignInPage,
                    builder: (context, value, child) {
                      return SizedBox.expand(
                        child: PageTransitionSwitcher(
                          reverse: !value,
                          duration: const Duration(milliseconds: 800),
                          transitionBuilder:
                              (child, animation, secondaryAnimation) {
                            return SharedAxisTransition(
                              animation: animation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType: SharedAxisTransitionType.vertical,
                              fillColor: Colors.transparent,
                              child: child,
                            );
                          },
                          child: value
                              ? SignIn(
                                  key: const ValueKey('SignIn'),
                                  onRegisterClicked: () {
                                    showSignInPage.value = false;
                                    _controller.forward();
                                  },
                                )
                              : SignUp(
                                  key: const ValueKey('Register'),
                                  onSignInPressed: () {
                                    showSignInPage.value = true;
                                    _controller.reverse();
                                  },
                                ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

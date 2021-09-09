import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'package:provider/provider.dart';

import './decoration_functions.dart';
import './sign_in_up_bar.dart';
import './title.dart';
//import '../../providers/auth_provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
    required this.onRegisterClicked,
  }) : super(key: key);

  final VoidCallback onRegisterClicked;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _hidePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _email = '';
    String _password = '';
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: LoginTitle(
                title: 'Welcome\nBack',
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Form(
              key: _formKey,
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: signInInputDecoration(
                          hintText: 'Email', icon: Icons.email),
                      autocorrect: false,
                      cursorColor: const Color(0xff092E34),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter an email.';
                        } else if (!value.trim().contains('@')) {
                          return 'Invalid Email';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        _email = newValue!.trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          decoration: signInInputDecoration(
                            hintText: 'Password',
                            icon: Icons.vpn_key,
                          ),
                          autocorrect: false,
                          cursorColor: const Color(0xff092E34),
                          obscureText: _hidePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Please enter a password.';
                            } else if (value.trim().length < 6) {
                              return 'Invalid Password';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            _password = newValue!.trim();
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          icon: _hidePassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          color: const Color(0xff092E34),
                        ),
                      ],
                    ),
                  ),
                  SignInBar(
                    label: 'Sign in',
                    color: const Color(0xff092E34),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // await Provider.of<AuthProvider>(context, listen: false)
                        //     .login(_email, _password)
                        //     .then((value) {
                        //   String? errorMessage = value;
                        //   SnackBar snackBar;
                        //   if (errorMessage != null) {
                        //     snackBar = SnackBar(
                        //       content: Container(
                        //         child: ListTile(
                        //           title: Text(errorMessage),
                        //           leading: Icon(Icons.error),
                        //         ),
                        //       ),
                        //       backgroundColor: Colors.amberAccent,
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: 10, vertical: 5),
                        //       duration: Duration(seconds: 2),
                        //     );
                        //   } else {
                        //     snackBar = SnackBar(
                        //       content: Container(
                        //         child: ListTile(
                        //           title: const Text('Successfully Signed In'),
                        //           leading: Icon(FontAwesomeIcons.checkCircle),
                        //         ),
                        //       ),
                        //       backgroundColor: Colors.tealAccent,
                        //       duration: Duration(seconds: 2),
                        //     );
                        //   }
                        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // });
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                        // Consumer<AuthProvider>(
                        //   builder: (_, authProvider, __) =>
                        InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        widget.onRegisterClicked.call();
                        // if (!authProvider.isLoading) {
                        //   widget.onRegisterClicked.call();
                        // }
                      },
                      child: const Text(
                        'Sign up',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff092E34),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    //),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

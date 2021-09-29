import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:retailer/providers/auth_provider.dart';
import 'package:retailer/services/firestore_service.dart';
import 'package:retailer/utils/curve_painter.dart';
import 'package:retailer/widgets/LoginScreen/decoration_functions.dart';
import 'package:retailer/widgets/ProfileScreen/profile_button.dart';
import 'package:retailer/widgets/ProfileScreen/profile_form.dart';

import '../data/global.dart';
import '../models/retailer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static final _formKey = new GlobalKey<FormState>();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditable = false;

  @override
  Widget build(BuildContext context) {
    String _name = '';
    String _phone = '';
    String _email = '';
    String _state = '';

    Retailer user = Global.userData!;

    return Container(
      color: const Color(0xff092E34),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
              height: MediaQuery.of(context).size.height * 0.2,
              child: CustomPaint(
                painter: CurvePainter(true, color: Colors.teal[800]),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color(0xFF3A5160).withOpacity(0.6),
                                offset: const Offset(2.0, 4.0),
                                blurRadius: 8),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60.0)),
                          child: Image.asset('assets/images/userImage.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _isEditable
                          ? Form(
                              key: ProfileScreen._formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      decoration: registerInputDecoration(
                                        hintText: 'Name',
                                        icon: FontAwesomeIcons.user,
                                      ),
                                      initialValue: user.name,
                                      keyboardType: TextInputType.name,
                                      autocorrect: false,
                                      cursorColor: Colors.white,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Please enter your name.';
                                        } else if (!RegExp('[a-zA-Z]')
                                            .hasMatch(value.trim())) {
                                          return 'Invalid name';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (newValue) {
                                        _name = newValue!.trim();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      decoration: registerInputDecoration(
                                        hintText: 'Phone',
                                        icon: FontAwesomeIcons.phone,
                                      ),
                                      initialValue: user.phone,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 2,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      autocorrect: false,
                                      cursorColor: Colors.white,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Please enter your phone number.';
                                        } else if (!RegExp('[0-9]')
                                                .hasMatch(value.trim()) ||
                                            value.trim().length != 10) {
                                          return 'Invalid Phone Number';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (newValue) {
                                        _phone = newValue!.trim();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      decoration: registerInputDecoration(
                                        hintText: 'State',
                                        icon: FontAwesomeIcons.mapMarker,
                                      ),
                                      initialValue: user.state,
                                      keyboardType: TextInputType.name,
                                      autocorrect: false,
                                      cursorColor: Colors.white,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Please enter your state.';
                                        } else if (!RegExp('[a-zA-Z]')
                                            .hasMatch(value.trim())) {
                                          return 'Invalid name';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (newValue) {
                                        _state = newValue!.trim();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      decoration: registerInputDecoration(
                                        hintText: 'Email',
                                        icon: Icons.mail,
                                      ),
                                      initialValue: user.email,
                                      keyboardType: TextInputType.streetAddress,
                                      autocorrect: false,
                                      cursorColor: Colors.white,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Please enter your email.';
                                        } else if (!value
                                            .trim()
                                            .contains('@')) {
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
                                ],
                              ),
                            )
                          : ProfileForm(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        child: _isEditable
                            ? Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProfileButton(
                                    text: ' SAVE ',
                                    onPressed: () async {
                                      if (ProfileScreen._formKey.currentState!
                                          .validate()) {
                                        ProfileScreen._formKey.currentState!
                                            .save();
                                        Retailer userData = Retailer(
                                          rid: user.rid,
                                          name: _name,
                                          phone: _phone,
                                          state: _state,
                                          email: _email,
                                        );
                                        await FirestoreService()
                                            .updateUser(userData)
                                            .then((value) =>
                                                Global.userData = userData);
                                        setState(() {
                                          _isEditable = false;
                                        });
                                      }
                                    },
                                  ),
                                  ProfileButton(
                                    text: 'CANCEL',
                                    onPressed: () {
                                      setState(() {
                                        _isEditable = false;
                                      });
                                    },
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ProfileButton(
                                    text: ' EDIT ',
                                    onPressed: () {
                                      setState(() {
                                        _isEditable = true;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ProfileButton(
                                    text: ' LOGOUT ',
                                    onPressed: () async {
                                      Global.userData = null;
                                      await Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .logout();
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

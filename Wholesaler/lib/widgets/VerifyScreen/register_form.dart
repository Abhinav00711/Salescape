import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../LoginScreen/decoration_functions.dart';
import '../../models/wholesaler.dart';
import '../../services/firestore_service.dart';
import '../../providers/auth_provider.dart';

class RegisterForm extends StatelessWidget {
  final String uid;
  static final _formKey = new GlobalKey<FormState>();

  RegisterForm({required this.uid});

  @override
  Widget build(BuildContext context) {
    String _name = '';
    String _phone = '';
    String _email = '';
    String _state = '';
    String _industry = '';

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                keyboardType: TextInputType.name,
                autocorrect: false,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your name.';
                  } else if (!RegExp('[a-zA-Z]').hasMatch(value.trim())) {
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
                keyboardType: TextInputType.phone,
                autocorrect: false,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your phone number.';
                  } else if (!RegExp('[0-9]').hasMatch(value.trim()) ||
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
                keyboardType: TextInputType.name,
                autocorrect: false,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your state.';
                  } else if (!RegExp('[a-zA-Z]').hasMatch(value.trim())) {
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
                keyboardType: TextInputType.streetAddress,
                autocorrect: false,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your email.';
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
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                decoration: registerInputDecoration(
                  hintText: 'Industry',
                  icon: FontAwesomeIcons.industry,
                ),
                keyboardType: TextInputType.name,
                autocorrect: false,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your industry.';
                  } else if (!RegExp('[a-zA-Z]').hasMatch(value.trim())) {
                    return 'Invalid industry';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _industry = newValue!.trim();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Center(
                child: ElevatedButton(
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF213333),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Wholesaler userData = Wholesaler(
                        wid: uid,
                        name: _name,
                        phone: _phone,
                        state: _state,
                        email: _email,
                        industry: _industry,
                      );
                      await FirestoreService().addUser(userData);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.checkCircle),
                                SizedBox(width: 20),
                                Text(
                                  'Registered Successfully',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.tealAccent,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      await Provider.of<AuthProvider>(context, listen: false)
                          .logout();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shadowColor: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
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

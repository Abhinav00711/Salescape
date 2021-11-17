import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/firestore_service.dart';
import '../utils/curve_painter.dart';
import '../widgets/LoginScreen/decoration_functions.dart';
import '../widgets/EditProfileScreen/profile_button.dart';
import '../data/global.dart';
import '../models/delivery.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  static final _formKey = new GlobalKey<FormState>();

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _name = '';
  String _phone = '';
  String _email = '';
  String _state = Global.userData!.state;

  List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  Delivery user = Global.userData!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowGlow();
                      return false;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                            key: EditProfileScreen._formKey,
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
                                    maxLength: 10,
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
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 12),
                                    decoration: new BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      horizontalTitleGap: 0,
                                      leading: const Icon(
                                        FontAwesomeIcons.mapMarker,
                                        color: Colors.white,
                                      ),
                                      title: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          menuMaxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          icon: Icon(
                                            Icons.arrow_drop_down_circle,
                                            color: Colors.white,
                                          ),
                                          hint: Text(
                                            'State',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          selectedItemBuilder:
                                              (BuildContext context) {
                                            return _states.map((String value) {
                                              return Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  _state,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }).toList();
                                          },
                                          isExpanded: true,
                                          items: _states.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          value: _state,
                                          onChanged: (value) {
                                            setState(() {
                                              _state = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProfileButton(
                                  text: ' SAVE ',
                                  onPressed: () async {
                                    if (EditProfileScreen._formKey.currentState!
                                        .validate()) {
                                      EditProfileScreen._formKey.currentState!
                                          .save();
                                      Delivery userData = Delivery(
                                        did: user.did,
                                        name: _name,
                                        phone: _phone,
                                        state: _state,
                                        email: _email,
                                        status: user.status,
                                      );
                                      await FirestoreService()
                                          .updateUser(userData)
                                          .then((value) =>
                                              Global.userData = userData);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                ProfileButton(
                                  text: 'CANCEL',
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

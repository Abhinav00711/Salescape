import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../LoginScreen/decoration_functions.dart';
import '../../models/wholesaler.dart';
import '../../services/firestore_service.dart';
import '../../providers/auth_provider.dart';

class RegisterForm extends StatefulWidget {
  final String uid;
  static final _formKey = new GlobalKey<FormState>();

  RegisterForm({required this.uid});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String _name = '';
  String _bname = '';
  String _phone = '';
  String _email = '';
  String _state = 'Andhra Pradesh';
  String _industry = 'Agriculture';
  String _paddress = '';
  List<String> _industries = [
    'Agriculture',
    'Healthcare and Pharmaceutical',
    'Infrastructure',
    'FMCG',
    'Fashion and Textiles',
    'Automobile',
    'Chemical',
    'Electronics and Appliances',
    'Furniture and Furnishing',
    'Sports and Fitness',
    'Household',
  ];

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: RegisterForm._formKey,
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
                  hintText: 'Business Name',
                  icon: FontAwesomeIcons.briefcase,
                ),
                keyboardType: TextInputType.name,
                autocorrect: false,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your business name.';
                  } else if (!RegExp('[a-zA-Z0-9]').hasMatch(value.trim())) {
                    return 'Invalid business name';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _bname = newValue!.trim();
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
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
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
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.white,
                      ),
                      hint: Text(
                        'State',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      selectedItemBuilder: (BuildContext context) {
                        return _states.map((String value) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _state,
                              style: const TextStyle(color: Colors.white),
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
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
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
                    FontAwesomeIcons.industry,
                    color: Colors.white,
                  ),
                  title: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.white,
                      ),
                      hint: Text(
                        'Industry',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      selectedItemBuilder: (BuildContext context) {
                        return _industries.map((String value) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _industry,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList();
                      },
                      isExpanded: true,
                      items: _industries.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _industry,
                      onChanged: (value) {
                        setState(() {
                          _industry = value!;
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
                  hintText: 'Pick-up Address',
                  icon: FontAwesomeIcons.addressBook,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 3,
                maxLength: 100,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                autocorrect: false,
                cursorColor: Colors.white,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your pick-up address.';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _paddress = newValue!.trim();
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
                    if (RegisterForm._formKey.currentState!.validate()) {
                      RegisterForm._formKey.currentState!.save();
                      Wholesaler userData = Wholesaler(
                        wid: widget.uid,
                        name: _name,
                        bname: _bname,
                        phone: _phone,
                        state: _state,
                        email: _email,
                        industry: _industry,
                        pickup_address: _paddress,
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

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/global.dart';
import '../../models/wholesaler.dart';
import '../LoginScreen/decoration_functions.dart';

class ProfileForm extends StatelessWidget {
  static final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Wholesaler user = Global.userData!;

    return Form(
      key: ProfileForm._formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: registerInputDecoration(
                hintText: 'Name',
                icon: FontAwesomeIcons.user,
              ),
              enabled: false,
              initialValue: user.name,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: registerInputDecoration(
                hintText: 'Business Name',
                icon: FontAwesomeIcons.briefcase,
              ),
              enabled: false,
              initialValue: user.bname,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: registerInputDecoration(
                hintText: 'Phone',
                icon: FontAwesomeIcons.phone,
              ),
              enabled: false,
              initialValue: user.phone,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: registerInputDecoration(
                hintText: 'State',
                icon: FontAwesomeIcons.mapMarker,
              ),
              enabled: false,
              initialValue: user.state,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: registerInputDecoration(
                hintText: 'Email',
                icon: Icons.mail,
              ),
              enabled: false,
              initialValue: user.email,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: registerInputDecoration(
                hintText: 'Industry',
                icon: FontAwesomeIcons.industry,
              ),
              enabled: false,
              initialValue: user.industry,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextFormField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: registerInputDecoration(
                hintText: 'Pick-up Address',
                icon: FontAwesomeIcons.addressBook,
              ),
              enabled: false,
              initialValue: user.pickup_address,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
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
            ),
          ),
        ],
      ),
    );
  }
}

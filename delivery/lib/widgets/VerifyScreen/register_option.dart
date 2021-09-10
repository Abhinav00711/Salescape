import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterOption extends StatelessWidget {
  const RegisterOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.clipboardList,
          size: 40,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.only(top: 8),
          child: const Text(
            'We need some of your basic information to start the super exciting journey.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

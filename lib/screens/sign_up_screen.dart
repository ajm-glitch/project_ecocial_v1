import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/smallerWidgets/apple_sign_up_button.dart';
import 'package:project_ecocial/screens/smallerWidgets/google_sign_up_button.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 110),
            Image(
              image: AssetImage('assets/ecocialIcon.png'),
            ),
            SizedBox(height: 40),
            Image(
              image: AssetImage('assets/greenNeighborhood.png'),
            ),
            SizedBox(height: 70),
            GoogleSignUpButtonWidget(),
            SizedBox(height: 20),
            Platform.isIOS ? AppleSignUpButtonWidget() : Container(),
          ],
        ),
      ),
    );
  }
}

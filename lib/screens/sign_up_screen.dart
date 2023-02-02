import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/smallerWidgets/apple_sign_up_button.dart';
import 'package:project_ecocial/screens/smallerWidgets/google_sign_up_button.dart';

class SignUpWidget extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        height: height,
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.07, horizontal: height * 0.01),
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/ecocialIcon.png'),
                ),
                SizedBox(height: height * 0.05),
                Image(
                  image: AssetImage('assets/greenNeighborhood.png'),
                ),
                SizedBox(height: height * 0.07),
                GoogleSignUpButtonWidget(),
                SizedBox(height: height * 0.03),
                Platform.isIOS ? AppleSignUpButtonWidget() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

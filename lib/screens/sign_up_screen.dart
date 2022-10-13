import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_ecocial/screens/smallerWidgets/google_sign_up_button.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);
//just a comment
  @override
  Widget build(BuildContext context) {
    return Center(
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
        ],
      ),
    );
  }
}

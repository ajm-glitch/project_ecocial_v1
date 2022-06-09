import 'package:flutter/material.dart';
import 'smaller widgets/google_sign_up_button.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

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

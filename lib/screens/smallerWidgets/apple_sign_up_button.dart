import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../authentication/auth_service_provider.dart';

class AppleSignUpButtonWidget extends StatelessWidget {
  const AppleSignUpButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton.extended(
        onPressed: () async {
          final provider =
              Provider.of<AuthServiceProvider>(context, listen: false);
          await provider.appleLogin();
        },
        elevation: 2.0,
        label: Text(
          "Sign in with Apple",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        icon: FaIcon(FontAwesomeIcons.apple, color: Colors.white),
      ),
    );
  }
}

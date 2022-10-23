import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_ecocial/authentication/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

class GoogleSignUpButtonWidget extends StatelessWidget {
  const GoogleSignUpButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton.extended(
        onPressed: () async {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          await provider.logIn();
          // Provider.of<MyPostsNotifier>(context, listen: false).listenToPosts();
        },
        elevation: 2.0,
        label: Text(
          "Sign in with Google",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
      ),
    );
  }
}

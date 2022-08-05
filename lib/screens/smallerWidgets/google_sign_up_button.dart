import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_ecocial/authentication/google_sign_in_provider.dart';
import 'package:provider/provider.dart';
import '../../database/notifiers/my_posts_notifier.dart';

class GoogleSignUpButtonWidget extends StatelessWidget {
  const GoogleSignUpButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: OutlineButton.icon(
        label: Text(
          'Log in with Google',
          style: TextStyle(fontSize: 20),
        ),
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //highlightedBorderColor: Color.fromRGBO(90, 155, 115, 1),
        borderSide: BorderSide(color: Color.fromRGBO(90, 155, 115, 1),),
        textColor: Colors.black,
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
        onPressed: () async {
          final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
          await provider.logIn();
          Provider.of<MyPostsNotifier>(context, listen: false).listenToPosts();
        },
      ),
    );
  }
}

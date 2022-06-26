import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/account_settings_screen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: [
            Image(
              image: AssetImage('assets/ecocialIcon.png'),
              width: 200,
              height: 200,
            ),
            buildMenuItem(
                text: "Home",
                onTapped: () => openScreen(context, '/home_screen')),
            Divider(),
            buildMenuItem(
                text: "Account Settings",
                onTapped: () => openScreen(context, '/account_settings_screen')),
            Divider(),
            buildMenuItem(
                text: "My Posts",
                onTapped: () {
                  setState(() {
                    openScreen(context, '/my_posts_screen');
                  });
                }),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({required String text, VoidCallback? onTapped}) {
    final color = Colors.black;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(text,
            style: TextStyle(
              color: color,
              fontSize: 20.0,
            )),
        onTap: onTapped,
      ),
    );
  }

  void openScreen(BuildContext context, String route) {
    if (route == '/home') {
      Navigator.pop(context);
    }
    else {
      Navigator.pushNamed(context, route);
    }
  }
}


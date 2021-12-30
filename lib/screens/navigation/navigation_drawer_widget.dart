import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: [
            buildMenuItem(
                text: "Home",
                onTapped: () => openScreen(context, '/home')),
            Divider(),
            buildMenuItem(
                text: "Account Settings",
                onTapped: () => openScreen(context, '/account_settings')),
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
      // How does this work? '/home' isn't said anywhere. Does it automatically
      // recognize it as the home route?
      Navigator.pop(context);
    }
    else {
      Navigator.pushNamed(context, route);
    }
  }

}


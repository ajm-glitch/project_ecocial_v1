import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ecocial/screens/account_settings_screen.dart';
import 'package:project_ecocial/screens/home_screen.dart';
import 'package:project_ecocial/screens/wrapper.dart';
import 'package:provider/provider.dart';

import 'authentication/google_sign_in_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoogleSignInProvider(),
      child: MaterialApp(
        home: Wrapper(),
        routes: { // CREATE ACCOUNT SETTINGS
          '/home' : (context) => HomeScreen(),
          '/account_settings': (context) => AccountSettings(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(101, 171, 200, 1),
          //accentColor: Color.fromRGBO(90, 155, 115, 1),
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromRGBO(101, 171, 200, 1),
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
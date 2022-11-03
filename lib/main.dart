import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_ecocial/database/notifiers/my_posts_notifier.dart';
import 'package:project_ecocial/database/notifiers/post_notifier.dart';
import 'package:project_ecocial/screens/account_settings_screen.dart';
import 'package:project_ecocial/screens/home_feed_screen.dart';
import 'package:project_ecocial/screens/my_posts_screen.dart';
import 'package:project_ecocial/screens/wrapper.dart';
import 'package:provider/provider.dart';

import 'authentication/google_sign_in_provider.dart';
import 'controllers/controller_instance.dart';
import 'controllers/data_manager_controller.dart';
import 'database/notifiers/comment_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Get.put(DataManagerController());
  dataManagerController.initializeControllers();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => PostNotifier()),
        ChangeNotifierProvider(create: (_) => MyPostsNotifier()),
        ChangeNotifierProvider(create: (_) => CommentNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          '/home_screen': (context) => HomeFeed(),
          '/account_settings_screen': (context) => AccountSettings(),
          '/my_posts_screen': (context) => MyPostsScreen(),
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

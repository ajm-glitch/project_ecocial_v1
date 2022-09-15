import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/authentication/google_sign_in_provider.dart';
import 'package:project_ecocial/database/user_db.dart';
import 'package:project_ecocial/screens/smallerWidgets/constants.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String username = "test";
  late TextEditingController usernameController =
      TextEditingController(text: "");

  @override
  initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    getUsername(currentUser?.uid).then((value) {
      if (mounted) {
        setState(() {
          if (value == null) {
            UserDb userDb = new UserDb();
            this.username = userDb.getUsernameFromEmail()!;
          } else {
            this.username = value;
          }
          usernameController = TextEditingController(text: this.username);
        });
        deactivate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    UserDb userDb = new UserDb();
    // setUsername();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text('Username:'),
              SizedBox(height: 20),
              TextFormField(
                  controller: usernameController,
                  decoration: textInputDecoration),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(38.0, 14.0, 38.0, 14.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        String username = usernameController.text;
                        bool result1 = userDb.pushUsernameToDb(username);
                        bool result2 = await userDb
                            .updateUsernameInPreviousPostsDb(username);
                        if (result1 == true && result2 == true) {
                          Toast.show("Saved!", duration: Toast.lengthShort);
                        } else {
                          print("error updating username");
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      // color: Color.fromRGBO(90, 155, 115, 1),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(50),
                      // ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  // TextButton(
                  //   onPressed: () async {
                  //     final provider = Provider.of<GoogleSignInProvider>(
                  //         context,
                  //         listen: false);
                  //          try {
                  //       await provider.logOut();
                  //       Navigator.pop(context);
                  //     } catch(e) {
                  //       print('logging out error: ' + e.toString());
                  //     }
                  //
                  //   },
                  //   child: Text(
                  //     'Log out',
                  //     style: TextStyle(
                  //       color: Color.fromRGBO(90, 155, 115, 1),
                  //     ),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () async {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      try {
                        await provider.logOut();
                        Navigator.pop(context);
                      } catch (e) {
                        print('logging out error: ' + e.toString());
                      }
                    },
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        color: Color.fromRGBO(90, 155, 115, 1),
                      ),
                    ),
                    // height: 50,
                    // minWidth: 100,
                    // shape: RoundedRectangleBorder(
                    //     side: BorderSide(
                    //         color: Color.fromRGBO(90, 155, 115, 1),
                    //         width: 2.0,
                    //         style: BorderStyle.solid),
                    //     borderRadius: BorderRadius.circular(50)
                    // ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getUsername(String? id) async {
    UserDb userDb = new UserDb();
    return userDb.getUsernameFromDb(id);
  }
}

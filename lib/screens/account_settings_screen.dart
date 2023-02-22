import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ecocial/database/user_db.dart';
import 'package:project_ecocial/screens/smallerWidgets/constants.dart';
import 'package:project_ecocial/screens/smallerWidgets/custom_round_dialog_widget.dart';
import 'package:project_ecocial/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../authentication/auth_service_provider.dart';
import '../database/notifiers/comment_notifier.dart';
import '../database/notifiers/my_posts_notifier.dart';
import '../database/notifiers/post_notifier.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String username = "test";
  late TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
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
                  child: Container(
                    child: FloatingActionButton.extended(
                      heroTag: "saveButton",
                      onPressed: () async {
                        String username = usernameController.text;
                        bool result1 = userDb.pushUsernameToDb(username);
                        bool result2 = await userDb
                            .updateUsernameInPreviousPostsDb(username);
                        if (result1 == true && result2 == true) {
                          Toast.show("Saved!", duration: Toast.lengthShort);
                        } else {
                          debugPrint("error updating username");
                        }
                      },
                      elevation: 2.0,
                      label: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Color.fromRGBO(90, 155, 115, 1),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: FloatingActionButton.extended(
                    heroTag: "logOutButton",
                    onPressed: () async {
                      try {
                        Provider.of<PostNotifier>(context, listen: false)
                            .closeListener();
                        Provider.of<MyPostsNotifier>(context, listen: false)
                            .closeListener();
                        Provider.of<CommentNotifier>(context, listen: false)
                            .closeListener();
                        // Navigator.pop(context);

                        Provider.of<AuthServiceProvider>(context, listen: false)
                            .logOut();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Wrapper()));
                      } catch (e) {
                        debugPrint('logging out error: ' + e.toString());
                      }
                    },
                    elevation: 2.0,
                    label: Text(
                      "Sign out",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
                // TextButton(
                //   onPressed: () async {
                //     final provider = Provider.of<GoogleSignInProvider>(
                //         context,
                //         listen: false);
                //     try {
                //       await provider.logOut();
                //       Navigator.pop(context);
                //     } catch (e) {
                //       print('logging out error: ' + e.toString());
                //     }
                //   },
                //   child: Text(
                //     'Log out',
                //     style: TextStyle(
                //       color: Color.fromRGBO(90, 155, 115, 1),
                //     ),
                //   ),
                //   // height: 50,
                //   // minWidth: 100,
                //   // shape: RoundedRectangleBorder(
                //   //     side: BorderSide(
                //   //         color: Color.fromRGBO(90, 155, 115, 1),
                //   //         width: 2.0,
                //   //         style: BorderStyle.solid),
                //   //     borderRadius: BorderRadius.circular(50)
                //   // ),
                // ),
              ],
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return CustomRoundDialogWidget(
                          noPadding: false,
                          horizontalPadding: 20,
                          displayedText: 'Account Deletion',
                          dialogContentWidget: accountDeletionWidget(),
                          onlyCloseOption: false,
                          submitText: "Delete account",
                          submitFunction: () async {
                            try {
                              Provider.of<PostNotifier>(context, listen: false)
                                  .closeListener();
                              Provider.of<MyPostsNotifier>(context, listen: false)
                                  .closeListener();
                              Provider.of<CommentNotifier>(context, listen: false)
                                  .closeListener();
                              final provider = Provider.of<AuthServiceProvider>(context, listen: false);
                              bool successful = await provider.accountDeletion(emailEditingController.text);
                              if (successful) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Wrapper()));
                              }
                              else {
                                Navigator.pop(context);
                                _scaffoldKey.currentState!.showBottomSheet((context) => Text("Unable to delete account",
                                  textAlign: TextAlign.center,));
                              }
                            } catch (e) {
                              debugPrint('logging out error: ' + e.toString());
                            }
                          },
                          closeText: "Cancel",
                        );
                      },
                    );
                  },
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                      color: Colors.red.shade900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget accountDeletionWidget() {
    return Column(
      children: [
        Text('Email:'),
        SizedBox(height: 20),
        TextFormField(
            controller: emailEditingController,
            decoration: textInputDecoration),
        SizedBox(height: 20),
        // Text('Password:'),
        // SizedBox(height: 20),
        // TextFormField(
        //     controller: passwordEditingController,
        //     obscureText: true,
        //     decoration: textInputDecoration),
        // SizedBox(height: 20),
      ],
    );
  }

  Future<String> getUsername(String? id) async {
    UserDb userDb = new UserDb();
    return userDb.getUsernameFromDb(id);
  }
}

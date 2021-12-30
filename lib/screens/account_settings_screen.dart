import 'package:flutter/material.dart';
import 'package:project_ecocial/authentication/google_sign_in_provider.dart';
import 'package:project_ecocial/screens/smaller%20widgets/constants.dart';
import 'package:provider/provider.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              TextField(
                decoration:
                textInputDecoration.copyWith(hintText: 'Replace with first part of email'),
              ),
              SizedBox(height: 40),
              // Text('Location:'),
              // SizedBox(height: 20),
              // TextField(
              //   decoration:
              //   textInputDecoration.copyWith(hintText: 'Replace with first part of email'),
              // ),
              // SizedBox(height: 40),
              Center(
                child: FlatButton(
                  minWidth: 100,
                  height: 46,
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen:false);
                    provider.logout();
                    // https://stackoverflow.com/questions/59576495/flutter-provider-nested-navigation
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      color: Color.fromRGBO(90, 155, 115, 1),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color.fromRGBO(90, 155, 115, 1),
                          width: 2.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50)),

                ),
              ),
            ],
          ),
        ),
      ),
      // body: Center(
      //     child: ElevatedButton(
      //         onPressed: () {
      //           final provider =
      //           Provider.of<GoogleSignInProvider>(context, listen:false);
      //           provider.logout();
      //         },
      //         child: Text('Log out')
      //     )
      // ),
    );
  }
}

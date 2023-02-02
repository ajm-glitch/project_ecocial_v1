import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/sign_up_screen.dart';
import 'package:project_ecocial/screens/wrapper.dart';

class FirstTimeWelcomeScreen extends StatelessWidget {
  const FirstTimeWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: height * 0.05),
            Image(
              image: AssetImage('assets/greenNeighborhood.png'),
            ),
            SizedBox(height: height * 0.05),
            Text(
              'Welcome to the Ecocial community!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            SizedBox(height: height * 0.05),
            Container(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'The idea is for people to take small everyday eco-friendly actions (such as carpooling with friends or recycling a plastic bottle from the street) and post about it here. Others will view these posts and provide encouragement for these actions by liking and/or commenting on posts.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            Container(
              child: FloatingActionButton.extended(
                heroTag: "getStartedButton",
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Wrapper()),
                          (route) => false);
                },
                elevation: 2.0,
                label: Text(
                  "Get started",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                backgroundColor: Color.fromRGBO(90, 155, 115, 1),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

}

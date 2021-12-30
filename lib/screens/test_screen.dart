import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("Entered test screen");
    return Scaffold(
      appBar: AppBar(
        title: Text("Test screen"),
      ),
      body: Center(
        child: Text("Hi!"),
      ),
    );
  }
}

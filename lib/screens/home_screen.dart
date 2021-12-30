import 'package:flutter/material.dart';
import 'package:project_ecocial/screens/create_post_screen.dart';
import 'package:project_ecocial/screens/smaller%20widgets/postCard.dart';
import 'package:project_ecocial/test_values.dart';
import 'navigation/navigation_drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final AuthService _auth = AuthService();

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePostScreen()));
        },
        child: Icon(Icons.post_add),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(90, 155, 115, 1),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return PostCard(postData: TestValues.posts[0],);
        },
      ),
      // body: Container(
      //   child: ElevatedButton(
      //       onPressed: () {
      //         final provider =
      //         Provider.of<GoogleSignInProvider>(context, listen:false);
      //         provider.logout();
      //       },
      //       child: Text('Log out')
      //   ),
      // ),
    );
  }
}


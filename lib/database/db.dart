import 'package:firebase_database/firebase_database.dart';

class db {

  final _db = FirebaseDatabase.instance.reference(); //database reference object

  void addData(String data) {
    _db.push().set({'name': data, 'comment': 'A good season'});
  }

  void printFirebase() {
    _db.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

// Snapshot[“id”] = “jfshfhfkshkh”

}
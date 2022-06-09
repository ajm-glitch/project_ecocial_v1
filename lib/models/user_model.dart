import 'package:firebase_auth/firebase_auth.dart';

class UserModel {

  final String id;
  final String username;
  final String email;
  final String defLocation;
  late final List<String> postIds;

  UserModel({required this.id, required this.username, required this.email, required this.defLocation});

}
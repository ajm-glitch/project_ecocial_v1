import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ffi';
import 'dart:io';
import '../../models/post_model.dart';

class PostContent extends StatelessWidget {
  final PostModel postData;
  const PostContent({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = postData.title;
    String content = postData.body;
    String imagePath = postData.imagePath;
    DateTime postTime = postData.postTime;
    String formattedPostTime = DateFormat('yyyy-MM-dd – kk:mm').format(postTime);
    String username = postData.username;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image(
          //   image: AssetImage(imagePath),
          // ),
          imagePath != "" ? Image.file(File(imagePath)) : SizedBox(height: 0,),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                    color: Color.fromRGBO(117, 117, 117, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.4
                ),
              ),
              Text(
                formattedPostTime,
                style: TextStyle(
                  color: Color.fromRGBO(196, 196, 196, 1),
                  fontSize: 12,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
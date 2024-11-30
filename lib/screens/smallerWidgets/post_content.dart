import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/post_model.dart';

class PostContent extends StatefulWidget {
  final PostModel postData;
  const PostContent({Key? key, required this.postData}) : super(key: key);

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {

  String imageDownloadUrl = "";

  void initState()  {
    super.initState();
    getDownloadUrl().then((value) {
      if (mounted) {
        setState(() {
          imageDownloadUrl = value;
        });
      }
    });
  }

  Future<String> getDownloadUrl() async {
    String url = "";
    if (widget.postData.imagePath != "") {
      String postId = widget.postData.id;
      final ref = FirebaseStorage.instance.ref().child('post_$postId' + '.jpg');
      url = await ref.getDownloadURL();
        }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.postData.title;
    String content = widget.postData.body;
    DateTime postTime = widget.postData.postTime;
    String formattedPostTime = DateFormat('yyyy-MM-dd – kk:mm').format(postTime);
    String username = widget.postData.username;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Image(
          //   image: AssetImage(imagePath),
          // ),
          imageDownloadUrl != "" ? Image.network(imageDownloadUrl) : SizedBox(height: 0,),
          // imagePath != "" ? Image.file(File(imagePath)) : SizedBox(height: 0,),
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
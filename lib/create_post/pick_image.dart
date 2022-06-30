import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

}

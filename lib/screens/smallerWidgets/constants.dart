import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration( // was const before>??
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(101, 171, 200, 1), // or Color.fromRGBO(90, 155, 115, 1)
      width: 2.0,
    ),
  ),
);


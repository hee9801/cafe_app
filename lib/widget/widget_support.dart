import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle boldTextFieldStyle() {
    return TextStyle(
            color: Colors.black, 
            fontSize: 22.0, 
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          );
  }

  static TextStyle HeadlineTextFieldStyle() {
    return TextStyle(
            color: Colors.black, 
            fontSize: 26.0, 
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          );
  }

  static TextStyle LightTextFieldStyle() {
    return TextStyle(
            color: Colors.black38, 
            fontSize: 18.0, 
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          );
  }

  static TextStyle SemiBoldTextFieldStyle() {
    return TextStyle(
            color: Colors.black, 
            fontSize: 18.0, 
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          );
  }
}
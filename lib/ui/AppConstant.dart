// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant {
  static Color appbarcolor = Colors.deepPurple;
  static Color backgroundColor = const Color.fromARGB(255, 142, 117, 188);
  static TextStyle textfancyheader = GoogleFonts.flavors(
    fontSize: 40,
    color: Colors.deepPurple[300],
  );
  static TextStyle textfancyheader2 = GoogleFonts.flavors(
    fontSize: 30,
    color: Colors.deepPurple[300],
  );

  static TextStyle textError = TextStyle(
    color: Colors.red[300],
    fontSize: 16,
    fontStyle: FontStyle.italic,
  );

  static TextStyle textlink = TextStyle(
    color: Colors.purple[300],
    fontSize: 16,
  );

  static TextStyle textbody = TextStyle(
    color: Colors.deepPurple[300],
    fontSize: 16,
  );

  static TextStyle textbodyfocus = TextStyle(
    color: Colors.deepPurple,
    fontSize: 20,
  );
}

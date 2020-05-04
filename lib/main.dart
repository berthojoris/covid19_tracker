import 'package:flutter/material.dart';
import 'package:tgd_covid_tracker/datasorce.dart';
import 'package:tgd_covid_tracker/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
        primaryColor: primaryBlack,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

import 'package:faceso/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white70,
        primaryColor: Colors.pink,
        accentColor: Colors.amber,
        //cursorColor: Colors.white,
      ),
      title: 'FACE SO',
      home: LoginScreen(),
    );
  }
}

import 'package:faceso/screens/customer_screen.dart';
import 'package:faceso/screens/home_screen.dart';
import 'package:faceso/screens/login_screen.dart';
import 'package:faceso/screens/message_screen.dart';
import 'package:faceso/screens/product_screen.dart';
import 'package:faceso/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ThaiSansNeue',
        scaffoldBackgroundColor: Colors.white70,
        primaryColor: Colors.pink,
        accentColor: Colors.amber,
        //cursorColor: Colors.white,
      ),
      title: 'FACE SO',
      //home: LoginScreen(),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/profile': (BuildContext context) => ProfileScreen(),
        '/customer': (BuildContext context) => CustomerScreen(),
        '/product': (BuildContext context) => ProductScreen(),
        '/message': (BuildContext context) => MessageScreen(),
      },
    );
  }
}

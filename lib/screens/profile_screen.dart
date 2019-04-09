import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen!!!\nข้อมูลส่วนตัว',
        style: TextStyle(
          fontSize: 30.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

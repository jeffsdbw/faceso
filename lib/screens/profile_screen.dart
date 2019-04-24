import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
          child: Container(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Icon(
                Icons.account_circle,
                size: 170.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Somkamol',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Somkamol Koohapremsilp',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              /*RaisedButton(
                  textColor: Colors.white,
                  color: Colors.pink,
                  child: Text(
                    " Sales Summary ",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  onPressed: () {
                    print('I believe');
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)))*/
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Message Screen!!!', style: TextStyle(fontSize: 30.0)),
    );
  }
}

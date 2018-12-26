import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Widget _buildContent(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildAvatar(),
        _buildInfo(context),
        _buildSignIn(),
      ],
    ),
  );
}

Widget _buildAvatar() {
  return Container(
    width: 165.0,
    height: 165.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white30),
    ),
    margin: const EdgeInsets.only(top: 100.0),
    padding: const EdgeInsets.all(3.0),
    child: ClipOval(
      //child: Image.asset(artist.avatar),
      child: Image(image: AssetImage('assets/images/logo6.png')),
    ),
  );
}

Widget _buildInfo(BuildContext context) {
  FocusNode _userFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  return Padding(
      padding: const EdgeInsets.only(top: 80.0, left: 60.0, right: 60.0),
      child: Form(
        child: Column(children: <Widget>[
          TextFormField(
            focusNode: _userFocus,
            textInputAction: TextInputAction.next,
            style: TextStyle(color: Colors.pinkAccent, fontSize: 20.0),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 30.0,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'User ID',
              labelStyle: new TextStyle(color: Colors.white),
            ),
            onFieldSubmitted: (v) {
              _userFocus.unfocus();
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
            /*
              decoration: new InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 3.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: const BorderSide(color: Colors.blue, width: 0.0),
                ),
                border: const OutlineInputBorder(),
                labelText: 'User ID',
                labelStyle: new TextStyle(color: Colors.green),
              ),
              */
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            //controller: ctrPassword,
            focusNode: _passwordFocus,
            textInputAction: TextInputAction.done,
            style: TextStyle(color: Colors.pinkAccent, fontSize: 20.0),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Password',
              labelStyle: new TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ]),

        /*
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Somkamol' + '\n' + 'Koohapremsilp',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        Text(
          'Klong Luang, Pathumthani',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          color: Colors.white.withOpacity(0.85),
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          width: 225.0,
          height: 1.0,
        ),
        Text(
          'I am smart mobile application developer',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            height: 1.4,
          ),
        ),
      ],
    ),
    */
      ));
}

Widget _buildSignIn() {
  // TODO
  //return Container();
  return new Container(
    margin: EdgeInsets.only(top: 20.0),
    width: 240.0,
    height: 50.0,
    alignment: FractionalOffset.center,
    decoration: new BoxDecoration(
      color: const Color.fromRGBO(247, 64, 106, 1.0),
      borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
    ),
    child: new Text(
      "Sign In",
      style: new TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.3,
      ),
    ),
  );
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //Image.asset(artist.backdropPhoto, fit: BoxFit.cover),
          Image(image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(
              color: Colors.black.withOpacity(0.75),
              child: _buildContent(context),
            ),
          ),
        ],
      ),
    );
  }
}

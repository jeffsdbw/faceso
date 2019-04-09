import 'dart:io';

import 'package:faceso/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'product_screen.dart';
import 'message_screen.dart';
import 'customer_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userID, userName, server, msg;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  //Loading counter value on start
  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userID = (prefs.getString('userID') ?? 'Unknow ID');
      userName = (prefs.getString('userName') ?? 'Unknow Name');
      server = (prefs.getString('server') ?? 'Unknow Server');
      msg = userID + ':' + userName + ':' + server;
      print(msg);
    });
  }

  int currentIndex = 0;
  List pages = [CustomerScreen(), ProductScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    String dID = userID, dName = userName, dServer = server;

    Widget appBar = AppBar(
      title: Text(
        'FaceSO!',
        style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              exit(0);
            }),
      ],
    );

    Widget floatingAction = FloatingActionButton(
      onPressed: () async {
        var response = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        print(response['name']);
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Colors.pinkAccent,
    );

    Widget bottomNavBar = BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text(
                'Customer',
                style: TextStyle(fontSize: 25.0),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              title: Text('Product', style: TextStyle(fontSize: 25.0))),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile', style: TextStyle(fontSize: 25.0))),
        ]);

    Widget drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo4.png'),
              // backgroundImage: NetworkImage(
              //     'https://randomuser.me/api/portraits/med/men/11.jpg'),
              /* backgroundColor: Colors.white70,
              child: Text(
                'SK',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45.0,
                    color: Colors.white),
              ),*/
            ),
            accountName: Text(
              dID,
              style: TextStyle(fontSize: 20.0),
            ),
            accountEmail: Text(
              dName,
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
              color: Colors.pink[400],
              image: DecorationImage(
                image: ExactAssetImage('assets/images/head5.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          /*DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(fontSize: 30),
            ),
            decoration: BoxDecoration(
              color: Colors.pink[400],
            ),
          ),*/
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'Customer List',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Customer Detail',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.store,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'Customer Stock',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Customer Stock Checking',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.attach_money,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'Customer Credit Note',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Credit Note Document',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.view_list,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'Product List',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Product Detail',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.local_shipping,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'Product Stock',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Product Stock Detail',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Your profile',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.pinkAccent,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Logout your account',
              style: TextStyle(fontSize: 20.0),
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pages[currentIndex],
      /*body: Center(
        child: Text('สวัสดีชาวโลก'),
      ),*/
      //floatingActionButton: floatingAction,
      bottomNavigationBar: bottomNavBar,
      drawer: drawer,
    );

    /*
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              child: Image(
                  image: AssetImage('assets/images/head4.jpg'),
                  fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.pink,
                height: 50.0,
                width: 50.0,
              ),
            ),
          ],
        ),
      ],
    );*/

    /*return Material(
      child: Center(
        child: Material(
          child: Text(
              'Hello World!\n' + dID + '\n' + dName + '\n' + dServer + '\n'),
        ),
      ),
    );*/
  }
}

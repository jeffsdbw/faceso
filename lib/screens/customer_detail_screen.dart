import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// ignore: must_be_immutable
class CustomerDetailScreen extends StatefulWidget {
  var params;

  CustomerDetailScreen(this.params);

  @override
  _CustomerDetailScreenState createState() =>
      _CustomerDetailScreenState(params);
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  var params;
  bool isLoading = true;
  bool chkImg = false;
  _CustomerDetailScreenState(this.params);
  var customer;
  String repName, repImage, custCode, repType;
  Future<Null> getCustomer() async {
    //final response = await http.get('https://randomuser.me/api/?results=20');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = (prefs.getString('server') ?? 'Unknow Server');
    String repcode = this.params;
    final response = await http
        .get(server + 'faceso/getCustomerDetail.php?repcode=' + repcode);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      isLoading = false;
      setState(() {
        customer = jsonResponse['results'];
        custCode = customer['rep_code'];
        repName = customer['rep_name'];
        repType = customer['rep_type'];
        if (customer['image'] == null || customer['image'].isEmpty) {
          chkImg = false;
        } else {
          chkImg = true;
        }
        repImage = customer['image'];
      });
    } else {
      print('Connection Error!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    Widget floatingAction = Padding(
      padding: EdgeInsets.only(bottom: 50.0),
      child: FloatingActionButton(
        onPressed: () async {
          //var response = await Navigator.push(
          //    context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          //print(response['name']);
          print('Call Customer!');
        },
        child: Icon(
          Icons.phone_in_talk,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );

    /*Widget floatingAction = FloatingActionButton(
      onPressed: () async {
        //var response = await Navigator.push(
        //    context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        //print(response['name']);
        print('Call Customer!');
      },
      child: Icon(
        Icons.phone_in_talk,
        color: Colors.white,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );*/

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Customer Detail',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: chkImg
                            ?
                            /*CircleAvatar(
                                backgroundImage: NetworkImage(
                                repImage,
                              ))*/
                            ClipOval(
                                child: Image.network(
                                repImage,
                                fit: BoxFit.cover,
                                width: 80.0,
                                height: 80.0,
                              ))
                            : Icon(
                                Icons.account_circle,
                                size: 100.0,
                              ),
                      ),
                      /*Icon(
                        Icons.account_circle,
                        size: 100.0,
                      ),*/
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              //custCode,
                              repName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            Text(
                              custCode,
                              style: TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                            Text(
                              repType,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  bool chkBranch = false;
                  bool chkShort = false;
                  bool dispB = false;
                  bool chkContact = false;
                  bool chkTel = false;
                  bool chkFax = false;
                  String dispS;
                  if (customer['address'][index]['branch'] == null ||
                      customer['address'][index]['branch'].isEmpty) {
                    chkBranch = false;
                  } else {
                    chkBranch = true;
                  }
                  if (customer['address'][index]['short_name'] == null ||
                      customer['address'][index]['short_name'].isEmpty) {
                    chkShort = false;
                  } else {
                    chkShort = true;
                  }
                  if (chkShort || chkBranch) {
                    dispB = true;

                    if (chkBranch) {
                      dispS = customer['address'][index]['short_name'] +
                          ' (' +
                          customer['address'][index]['branch'] +
                          ')';
                    } else {
                      dispS = customer['address'][index]['short_name'];
                    }
                  }
                  if (customer['address'][index]['contact'] == null ||
                      customer['address'][index]['contact'].isEmpty) {
                    chkContact = false;
                  } else {
                    chkContact = true;
                  }
                  if (customer['address'][index]['tel_no'] == null ||
                      customer['address'][index]['tel_no'].isEmpty) {
                    chkTel = false;
                  } else {
                    chkTel = true;
                  }
                  if (customer['address'][index]['fax_no'] == null ||
                      customer['address'][index]['fax_no'].isEmpty) {
                    chkFax = false;
                  } else {
                    chkFax = true;
                  }
                  return (Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        textDirection: TextDirection.ltr,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            customer['address'][index]['adr_type'],
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          dispB
                              ? Text(
                                  dispS,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                )
                              : Container(),
                          Text(
                            customer['address'][index]['address'],
                            style: TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.left,
                          ),
                          chkContact
                              ? Text(
                                  'Contact : ' +
                                      customer['address'][index]['contact'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                )
                              : Container(),
                          chkTel
                              ? Text(
                                  'Tel. No  : ' +
                                      customer['address'][index]['tel_no'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                )
                              : Container(),
                          chkFax
                              ? Text(
                                  'Fax No  : ' +
                                      customer['address'][index]['fax_no'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      /*Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              height: 100.0,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    customer['address'][index]['address'],
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.blue),
                              height: 100.0,
                            ),
                            flex: 1,
                          ),
                        ],
                      ),*/
                      /*child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            color: Colors.pink,
                            height: 100.0,
                            width: 100.0,
                          ),
                          Container(
                            color: Colors.blue,
                            height: 100.0,
                            width: 100.0,
                          ),
                        ],
                      ),*/
                    ),
                    /*child: Column(
                      children: <Widget>[
                        Text('Line1'),
                        Text('Line2'),
                        Text('Line1'),
                      ],
                    ),*/
                  ));
                },
                itemCount: customer['address'] != null
                    ? customer['address'].length
                    : 0,
              ),
              /*Container(
                color: Colors.lightBlue,
                height: 100.0,
              ),*/
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /*ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.store),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text('Stock!'),
                        ],
                      ),
                    ),
                    color: Colors.pinkAccent,
                  ),
                ),*/
                new RaisedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.store,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Stock',
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: Theme.of(context).primaryColor,
                  elevation: 4.0,
                  splashColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {
                    print('Press Stock!');
                  },
                ),
                new RaisedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Credit Note',
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: Theme.of(context).primaryColor,
                  elevation: 4.0,
                  splashColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {
                    print('Press Credit Note!');
                  },
                ),
                /*Ink(
                  decoration: ShapeDecoration(
                    color: Colors.purple,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.store),
                    tooltip: 'Stock Tooltip!',
                    onPressed: () {
                      print('Hi you pressed me!');
                    },
                  ),
                ),*/
                /*RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ) +
                        Border.all(color: Colors.blue),
                    elevation: 4.0,
                    icon: Icon(
                      Icons.store,
                      color: Colors.white,
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      print('Check Stock!');
                    },
                    label: Text("Stock",
                        style: TextStyle(color: Colors.white, fontSize: 16.0))),*/
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: floatingAction,
    );
  }
}

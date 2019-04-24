import 'package:flutter/material.dart';

class CustomerDetailScreen extends StatefulWidget {
  var params;

  CustomerDetailScreen(this.params);

  @override
  _CustomerDetailScreenState createState() =>
      _CustomerDetailScreenState(params);
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  var params;

  _CustomerDetailScreenState(this.params);

  @override
  Widget build(BuildContext context) {
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
                      Icon(
                        Icons.account_circle,
                        size: 100.0,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'บริษัท อีฟ แอนด์ บอย จำกัด',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Row /*or Column*/ (
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.star, size: 50),
                              Icon(Icons.star, size: 50),
                              Icon(Icons.star, size: 50),
                            ],
                          ),
                          /*Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                color: Colors.pink,
                                height: 100.0,
                                width: 100.0,
                                child: Text(
                                  'Col 01!',
                                  style: TextStyle(fontSize: 30.0),
                                ),
                              ),
                              Container(
                                color: Colors.lightBlue,
                                height: 100.0,
                                width: 100.0,
                              ),
                            ],
                          ),*/
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            new Expanded(
              child: Container(
                color: Colors.lightBlue,
                height: 100.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

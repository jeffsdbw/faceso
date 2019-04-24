import 'package:faceso/screens/customer_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  var customers;
  bool isLoading = true;
  TextEditingController ctrSearch = TextEditingController();

  Future<Null> getCustomers() async {
    //final response = await http.get('https://randomuser.me/api/?results=20');
    final response = await http.get(
        'http://dsmservice.mistine.co.th/bsmart/faceso/getCustomer.php?search=' +
            ctrSearch.text);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      isLoading = false;
      setState(() {
        customers = jsonResponse['results'];
      });
    } else {
      print('Connection Error!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _searchFocus = new FocusNode();
    return new Column(children: <Widget>[
      Container(
        padding: new EdgeInsets.only(left: 20.0, right: 20.0),
        color: Colors.white,
        child: TextFormField(
          controller: ctrSearch,
          focusNode: _searchFocus,
          textInputAction: TextInputAction.next,
          style: TextStyle(color: Colors.black, fontSize: 25.0),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: 25.0,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Search Customer',
            labelStyle: new TextStyle(color: Colors.grey, fontSize: 25.0),
          ),
          onFieldSubmitted: (v) {
            _searchFocus.unfocus();
            //print('Search Customer Process!!!');
            getCustomers();
            //FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
      ),
      /*Card(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2, // 20%
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      'Search1',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    height: 25.0,
                  ),
                ),
                Expanded(
                  flex: 6, // 60%
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      'Search2',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    height: 25.0,
                  ),
                ),
                Expanded(
                  flex: 2, // 20%
                  child: Container(
                    color: Colors.red,
                    child: Text(
                      'Search3',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    height: 25.0,
                  ),
                )
              ],
            )),*/
      new Expanded(
        child: RefreshIndicator(
          onRefresh: getCustomers,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Card(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      bool chkImg = false;
                      if (customers[index]['image'] == null ||
                          customers[index]['image'].isEmpty) {
                        chkImg = false;
                      } else {
                        chkImg = true;
                      }
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: chkImg
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                    customers[index]['image'],
                                  ))
                                : Icon(
                                    Icons.account_circle,
                                    size: 50.0,
                                  ),
                            /*leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  //customers[index]['picture']['medium']),
                                  'https://randomuser.me/api/portraits/med/women/6.jpg'),
                            ),*/
                            onTap: () {
                              print('Customer:' + customers[index]['code']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerDetailScreen(
                                              customers[index]['code'])));
                            },
                            title: Text(
                              '${customers[index]['name']}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            subtitle: Text(
                              '${customers[index]['code']} \n${customers[index]['type']}',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          Divider(),
                        ],
                      );
                    },
                    itemCount: customers != null ? customers.length : 0,
                  ),
                ),
        ),
      ),
      /*
    return Card(
      child: ListView.builder(
        itemBuilder: (context, int index) {
          return ListTile(
            onTap: () {},
            title: Text(
              '${customers[index]['name']['first']} ${customers[index]['name']['last']}',
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text('${customers[index]['email']}'),
            trailing: Icon(Icons.keyboard_arrow_right),
          );
        },
        itemCount: customers != null ? customers.length : 0,
      ),
    );*/
    ]);
  }
}

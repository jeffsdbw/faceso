import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var products;
  bool isLoading = true;
  TextEditingController ctrSearch = TextEditingController();

  Future<Null> getProducts() async {
    //final response = await http.get('https://randomuser.me/api/?results=20');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = (prefs.getString('server') ?? 'Unknow Server');
    final response = await http
        .get(server + 'faceso/getProduct.php?search=' + ctrSearch.text);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      isLoading = false;
      setState(() {
        products = jsonResponse['results'];
      });
    } else {
      print('Connection Error!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
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
            labelText: 'Search Product',
            labelStyle: new TextStyle(color: Colors.grey, fontSize: 25.0),
          ),
          onFieldSubmitted: (v) {
            _searchFocus.unfocus();
            //print('Search Customer Process!!!');
            getProducts();
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
          onRefresh: getProducts,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Card(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      bool chkImg = false;
                      if (products[index]['image'] == null ||
                          products[index]['image'].isEmpty) {
                        chkImg = false;
                      } else {
                        chkImg = true;
                      }
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: chkImg
                                ? Image(
                                    image:
                                        NetworkImage(products[index]['image']),
                                    height: 80.0,
                                    width: 80.0,
                                  )
                                /*? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                    products[index]['image'],
                                  ))*/
                                : Icon(
                                    Icons.redeem,
                                    size: 50.0,
                                  ),
                            onTap: () {},
                            title: Text(
                              '${products[index]['lname']}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            subtitle: Text(
                              '${products[index]['code']} : ${products[index]['ename']}',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
                          Divider(),
                        ],
                      );
                    },
                    itemCount: products != null ? products.length : 0,
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

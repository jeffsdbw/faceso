import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Product Screen!!!\nข้อมูลสินค้า',
        style: TextStyle(
          fontSize: 30.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

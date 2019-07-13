import 'package:flutter/material.dart';
import 'objects/Quotation.dart';
import 'package:http/http.dart' as http;

void main() async=> runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor de moeda \$"),
        centerTitle: true,
        backgroundColor: Colors.amber
      ),
      body: ,
    );
  }
}

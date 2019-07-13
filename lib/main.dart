import 'package:flutter/material.dart';
import 'objects/Quotation.dart';

void main() async {
  runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
      )));
  }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var quotation = Quotation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text("\$ Conversor de moeda \$"),
          centerTitle: true,
          backgroundColor: Colors.amber),
      body: FutureBuilder(
          future: quotation.getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text("Carregando...",
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        textAlign: TextAlign.center));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text("Erro!",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                          textAlign: TextAlign.center));
                } else {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on,
                            size: 150.0, color: Colors.amber),
                        buildTextField("Reias", "R\$"),
                        Divider(),
                        buildTextField("Dolares", "US\$"),
                        Divider(),
                        buildTextField("Euros", "€"),
                        Divider(),
                        buildTextField("Bitcoins", "BTC\$")
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextField(String label, String prefix
    /*, TextEditingController controller*/) {
  return TextField(
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    /*controller: controller,*/
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber)),
        prefixText: prefix),
  );
}

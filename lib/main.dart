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

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final btcController = TextEditingController();

  void _realChanged(String valueText) {
    if(valueText.isEmpty) {
      _clearAll();
      return;
    }

    var amount = double.parse(valueText);
    dolarController.text = (amount / quotation.usd).toStringAsFixed(2);
    euroController.text = (amount / quotation.eu).toStringAsFixed(2);
    btcController.text = (amount / quotation.btc).toStringAsFixed(10);
  }

  void _dolarChanged(String valueText) {
    if(valueText.isEmpty) {
      _clearAll();
      return;
    }

    var amount = double.parse(valueText);
    var real = quotation.dolarToReal(amount);
    realController.text = real.toStringAsFixed(2);
    euroController.text = (real / quotation.eu).toStringAsFixed(2);
    btcController.text = (real / quotation.btc).toStringAsFixed(10);
  }

  void _euroChanged(String valueText) {
    if(valueText.isEmpty) {
      _clearAll();
      return;
    }

    var amount = double.parse(valueText);
    var real = quotation.euToReal(amount);
    realController.text = real.toStringAsFixed(2);
    dolarController.text = (real / quotation.usd).toStringAsFixed(2);
    btcController.text = (real / quotation.btc).toStringAsFixed(10);
  }

  void _btcChanged(String valueText) {
    if(valueText.isEmpty) {
      _clearAll();
      return;
    }

    var amount = double.parse(valueText);
    var real = quotation.bitcoinToReal(amount);
    realController.text = real.toStringAsFixed(2);
    dolarController.text = (real * quotation.usd).toStringAsFixed(2);
    euroController.text = (real * quotation.eu).toStringAsFixed(10);
  }

  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
    btcController.text = "";
  }


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
                        Divider(),
                        buildTextField("Reias", "R\$", realController, _realChanged),
                        Divider(),
                        buildTextField("Dolares", "US\$", dolarController, _dolarChanged),
                        Divider(),
                        buildTextField("Euros", "€", euroController, _euroChanged),
                        Divider(),
                        buildTextField("Bitcoins", "BTC\$", btcController, _btcChanged)
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextField(String label, String prefix, TextEditingController controller, Function function) {
  return TextField(
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    controller: controller,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onChanged: function,
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

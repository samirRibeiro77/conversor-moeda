import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'Coin.dart';

class Quotation {
  static const String requestUrl = "https://api.hgbrasil.com/finance?format=json&key=ea3cbde1";

  Coin _usd, _euro, _btc;

  Future<Map> getData() async {
    var httpRequest = await http.get(requestUrl);
    var quotationJson = json.decode(httpRequest.body);

    _usd = Coin(
        quotationJson["results"]["currencies"]["USD"]["buy"],
        quotationJson["results"]["currencies"]["USD"]["sell"]
    );

    _euro = Coin(
        quotationJson["results"]["currencies"]["EUR"]["buy"],
        quotationJson["results"]["currencies"]["EUR"]["sell"]
    );

    _btc = Coin(
        quotationJson["results"]["currencies"]["BTC"]["buy"],
        quotationJson["results"]["currencies"]["BTC"]["sell"]
    );

    return quotationJson;
  }

  double get usd => _usd.value;
  double get eu => _euro.value;
  double get btc => _btc.value;

  get quotation => "Dólar: ${usd.toStringAsFixed(2)}\nEuro: ${eu.toStringAsFixed(2)}\nBitcoin: ${btc.toStringAsFixed(2)}";

  double euToReal(value) {
    return value * eu;
  }

  double dolarToReal(value) {
    return value * usd;
  }

  double bitcoinToReal(value) {
    return value * btc;
  }
}
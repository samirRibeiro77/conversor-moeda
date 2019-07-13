import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Quotation {
  static const String requestUrl = "https://api.hgbrasil.com/finance?format=json&key=ea3cbde1";

  Future<Map> getData() async {
    var httpRequest = await http.get(requestUrl);
    return json.decode(httpRequest.body);
  }
}
import 'dart:convert';

import 'package:http/http.dart' as http;

var link = "https://opentdb.com/api.php?amount=20";

getApiData() async {
  var response = await http.get(Uri.parse(link));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    print("data is loaded");
    return data;
  }
}

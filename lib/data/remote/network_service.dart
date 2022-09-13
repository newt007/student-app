import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkService {
  Future<dynamic> getMethod(String endpoint) async {
    try {
      print("requested endpoint : $endpoint");
      final getResponse = await http
          .get(Uri.parse("$endpoint"));
      var res = json.decode(getResponse.body);

      if (res['status_message'] == null)
        return res;
      else
        return Exception(res['status_message']);
    } on SocketException {
      throw Exception("Connection failed");
    }
  }

  Future<dynamic> postMethod(String endpoint, Map<String, dynamic> body) async {
    try {
      print("requested endpoint : $endpoint");
      final postResponse = await http.post(Uri.parse(endpoint), body: body);
      var res = json.decode(postResponse.body);

      return res;
    } on SocketException {
      throw Exception("Connection failed");
    }
  }

  Future<dynamic> updateMethod(
      String endpoint, Map<String, dynamic> body) async {
    try {
      print("requested endpoint : $endpoint");
      final updateResponse = await http.put(
        Uri.parse(endpoint),
        body: body,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      var res = json.decode(updateResponse.body);

      return res;
    } on SocketException {
      throw Exception("Connection failed");
    }
  }

  Future<dynamic> deleteMethod(String endpoint) async {
    try {
      print("requested endpoint : $endpoint");
      final deleteResponse = await http.delete(Uri.parse(endpoint));

      var res = json.decode(deleteResponse.body);

      return res;
    } on SocketException {
      throw Exception("Connection failed");
    }
  }
}

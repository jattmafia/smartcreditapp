import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smartcredit/config.dart';

class HttpService {
  static Future<dynamic> get({
    required String tabel,
    dynamic query,
  }) async {
    var headers = {'apiKey': API_KEY};
    var queryParameters = query != null
        ? query.entries
            .map((entry) =>
                '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
            .join('&')
        : '';
    print(tabel + queryParameters);
    var request =
        http.Request('GET', Uri.parse('$API_URL/$tabel?$queryParameters'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      // print(data);
      return data;
    } else {
      // print();
      return data;
    }
  }

  static Future<dynamic> getById(
      {required String table, required String id}) async {
    var headers = {'apiKey': API_KEY};
    var request = http.Request('GET', Uri.parse('$API_URL/$table/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return "";
    }
  }

  static Future<http.StreamedResponse> postdoc(
      {required String tabel, dynamic query, required File? image}) async {
    var headers = {'apiKey': API_KEY};
    var response = http.MultipartRequest(
      'POST',
      Uri.parse('$API_URL/$tabel'),
    );

    response.headers.addAll(headers);
    response.fields.addAll(query);
    response.files.add(await http.MultipartFile.fromPath('image', image!.path));
    var data = await response.send();
    ;

    return data;
  }

  static Future<http.Response> post({
    required String tabel,
    dynamic query,
  }) async {
    var headers = {'apiKey': API_KEY};
    var response = await http.post(Uri.parse('$API_URL/$tabel'),
        headers: headers, body: jsonEncode(query));

    return response;
  }

  static Future<dynamic> getmeds({
    required String tabel,
    dynamic query,
  }) async {
    var headers = {'apiKey': API_KEY};

    var request = http.Request('GET', Uri.parse('$API_URL/$tabel'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      // print(data);
      return data;
    } else {
      // print();
      return data;
    }
  }

  static Future<http.Response> delete({
    required String tabel,
  }) async {
    var headers = {'apiKey': API_KEY};
    var response = await http.delete(
      Uri.parse('$API_URL/$tabel'),
      headers: headers,
    );

    return response;
  }

  static Future<http.Response> update(
      {required String tabel, dynamic query}) async {
    var headers = {'apiKey': API_KEY};
    var response = await http.put(Uri.parse('$API_URL/$tabel'),
        headers: headers, body: jsonEncode(query));

    return response;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> executeapi(data) async {
  var url = Uri.parse(data['url']);
  var response;
  if (data['methods'] == 'get') {
    response = await http.get(url, headers: data['headers']);
  } else if (data['methods'] == 'post') {
    response =
        await http.post(url, headers: data['headers'], body: data['body']);
  } else if (data['methods'] == 'put') {
    response =
        await http.delete(url, headers: data['headers'], body: data['body']);
  } else if (data['methods'] == 'delete') {
    response =
        await http.post(url, headers: data['headers'], body: data['body']);
  }
  return response.body;
}

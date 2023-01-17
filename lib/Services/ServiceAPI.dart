import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final URL_API = "http://52.146.91.57:8080/api/";
final HEADERS_REQUEST = {"Content-Type": "application/json;charset=UTF-8"};


Future request_POST(url_complement,body_request) async {
  var URL_FULL = Uri.parse(URL_API+url_complement);
  //print("========= BODY =========\n $body_request");
  //print("========= URL ==========\n $URL_FULL");
  final res = await http.post(URL_FULL, headers: HEADERS_REQUEST, body: jsonEncode(body_request));
  //var resultado = jsonDecode(res.body);
  //print("=== RESULTADO ====\n $resultado");
  return res;
}

Future request_PUT(url_complement,body_request) async {

  final res = await http.put(Uri.parse(URL_API+url_complement), headers: HEADERS_REQUEST, body: jsonEncode(body_request));
  return jsonDecode(res.body);
}

Future request_GET(url_complement) async {
  var URL_FULL = Uri.parse(URL_API + url_complement);
  final res = await http.get(URL_FULL, headers: HEADERS_REQUEST);

  var json_Response = jsonDecode(res.body);

  print("RESULTADO EN SERVICE $json_Response");
  
  return res;
}

Future request_DELETE(url_complement) async {
  final res = await http.delete(Uri.parse(URL_API+url_complement), headers: HEADERS_REQUEST);
  return jsonDecode(res.body);
}

Future request_FORMDATA(url_complement,name_field,path_image) async {
  var request = new http.MultipartRequest("POST",Uri.parse(URL_API+url_complement) );
  request.files.add(
      await http.MultipartFile.fromPath(
          name_field,
          path_image
      )
  );
  request.send().then((response) => print(response));

  /*
  final res = await http.MultipartRequest("POST",Uri.parse(URL_API+url_complement)).files.add(
      await http.MultipartFile.fromPath(
          name_field,
          path_image
      )
  );
  return jsonDecode(res.body);
   */
}
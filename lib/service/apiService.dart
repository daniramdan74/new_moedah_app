// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static _setHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  static _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    // String token =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOTIuMTY4LjQzLjEyN1wvYXBpXC9sb2dpbiIsImlhdCI6MTYwODMyMTU2MywiZXhwIjoxNjA4MzI1MTYzLCJuYmYiOjE2MDgzMjE1NjMsImp0aSI6IklQSVRrYmRDM2xlZTZicmwiLCJzdWIiOjEwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.vtr9ZchjrssGq8y5hDKVMlKvLgY30fouthirDVrlr4o';
    return '?token=$token';
  }

  // static final String _url = 'http://192.168.0.4:80/api/';
  static final String _url = 'http://192.168.43.127:80/api/';

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    // print(fullUrl);
    return await http.get(fullUrl, headers: _setHeaders());
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  updateData(id, data, apiUrl) async {
    var fullUrl = _url + apiUrl + '/' + id + await _getToken();
    return await http.put(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }
  updateDataProfile(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  deleteData(id, apiUrl) async {
    var fullUrl = _url + apiUrl + '/' + id + await _getToken();
    return await http.delete(fullUrl, headers: _setHeaders());
  }
}

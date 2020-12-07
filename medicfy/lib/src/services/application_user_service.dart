import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicfy/src/models/login_model.dart';
import 'package:medicfy/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApplicationUserService {
  static String base_url =
      'http://kraamax-001-site1.gtempurl.com/api/ApplicationUser';

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  static final storage = new FlutterSecureStorage();
  static Future postUser(User user) async {
    final _user = user.toMap();
    print(_user);
    final body = json.encode(_user);
    final response =
        await http.post(base_url + "/Register", headers: header, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<http.Response> login(LoginModel loginModel) async {
    final _loginModel = loginModel.toMap();
    final body = json.encode(_loginModel);
    final response =
        await http.post(base_url + "/Login", headers: header, body: body);
    final decoded = json.decode(response.body);
    storage.deleteAll();
    await storage.write(key: 'jwt', value: decoded['token']);
    return response;
  }
}

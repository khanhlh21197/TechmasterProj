import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'shared_preferences_manager.dart';

enum Method { get, post, put, delete }

// Singleton
class ApiService {
  factory ApiService() => _manager;
  static final _manager = ApiService._internal();

  ApiService._internal();

  final baseUrl = 'http://report.bekhoe.vn';
  final register = '/api/accounts/Register';
  final login = '/api/accounts/login';
  final uploadImage = '/api/upload';
  final profile = '/api/accounts/profile';
  final updateProfile = '/api/accounts/update';
  final changePassword = '/api/accounts/changePassword';
  final postIssue = '/api/issues';
  var token = '';

  Future<void> request({
    String path,
    Method method,
    Map<String, dynamic> parameters,
    Function(dynamic) onSuccess,
    Function(String) onFailure,
  }) async {
    token = sharedPreferences.getString(key: tokenKey);

    final headers = {
      'Authorization': 'Bearer $token',
    };

    http.Response response;

    switch (method) {
      case Method.get:
        response = await http.get(baseUrl + path, headers: headers);
        break;
      case Method.post:
        response = await http.post(
          baseUrl + path,
          headers: headers,
          body: parameters,
          encoding: utf8,
        );
        break;
      default:
        break;
    }

    if (response == null) return;

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final code = json['code'];
      if (code == 0) {
        print('login thanh cong');
        final data = json['data'];
        onSuccess(data);
      } else {
        onFailure(json['message']);
      }
    } else {
      onFailure('loi, http status code ${response.statusCode}');
    }
  }

  Future<void> upload({
    File image,
    Function(String) onSuccess,
    Function(String) onFailure,
  }) async {
    token = sharedPreferences.getString(key: tokenKey);
    print('ApiService.upload $token');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl + '/api/upload'),
    );

    request.headers.addAll(headers);

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      await image.readAsBytes(),
      filename: image.path.split('/').last ?? 'hieutao.jpg',
    ));

    final stream = await request.send();
    final response = await http.Response.fromStream(stream);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      final code = json['code'];
      if (code == 0) {
        print('${json['data']}');
      } else {}
    } else {}
  }
}

final apiService = ApiService();

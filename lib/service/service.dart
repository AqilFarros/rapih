import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapih/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_service.dart';
part 'laundry_service.dart';

String baseUrl = "http://192.168.0.47:8000/api";
var client = http.Client();

abstract class ApiService {
  static Future<ApiReturnValue<T>> handleResponse<T>(
      Future<T> Function() response) async {
    try {
      final result = await response();
      return ApiReturnValue(value: result);
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  static header({String? token}) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token ?? User.token}'
    };
  }

  static get({required String url, required String errorMesssage, String? token,}) async {
    var response = await client.get(
      Uri.parse(url),
      headers: header(token: token),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(errorMesssage);
    } else {
      return jsonDecode(response.body);
    }
  }

  static post({
    required String url,
    Map<String, dynamic>? body,
    required String errorMessage,
    String? token,
  }) async {
    var response = await client.post(
      Uri.parse(url),
      headers: header(token: token),
      body: jsonEncode(body),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(errorMessage);
    } else {
      return jsonDecode(response.body);
    }
  }
}

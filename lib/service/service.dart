import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rapih/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_service.dart';
part 'laundry_service.dart';
part 'wallet_service.dart';
part 'category_service.dart';
part 'product_service.dart';
part 'customer_service.dart';
part 'parfume_service.dart';
part 'delivery_service.dart';
part 'discount_service.dart';
part 'layanan_service.dart';
part 'absence_service.dart';
part 'cashier_service.dart';
part 'order_service.dart';

String baseUrl = "http://192.168.0.29:8000/api";
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
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? User.token}'
    };
  }

  static get({
    required String url,
    required String errorMessage,
    String? token,
  }) async {
    var response = await client.get(
      Uri.parse(url),
      headers: header(token: token),
    );

    print(response.body);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(errorMessage);
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

  static put(
      {required String url,
      required String errorMessage,
      String? token}) async {
    var response = await client.put(
      Uri.parse(url),
      headers: header(token: token),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(errorMessage);
    } else {
      return jsonDecode(response.body);
    }
  }

  static delete({
    required String url,
    required String errorMessage,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    var response = await client.delete(
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

  static postDataWithImage({
    required String url,
    required List<Map<String, dynamic>>? fields,
    required List<Map<String, dynamic>> files,
    required String errorMessage,
  }) async {
    final uri = Uri.parse(url);

    var request = http.MultipartRequest("POST", uri)..headers.addAll(header());

    if (fields != null) {
      for (var item in fields) {
        request.fields[item.keys.first] = item.values.first;
      }
    }

    for (var item in files) {
      request.files.add(await http.MultipartFile.fromPath(
          item.keys.first, item.values.first));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(errorMessage);
    } else {
      return jsonDecode(response.body);
    }
  }
}

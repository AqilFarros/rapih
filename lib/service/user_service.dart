part of 'service.dart';

class UserService {
  static Future<ApiReturnValue<User>> signIn({
    required String email,
    required String password,
  }) async {
    String url = "$baseUrl/login";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: <String, dynamic>{
          "email": email,
          "password": password,
        },
        errorMessage: "Failed to sign in",
      );

      await prefs.setString('token', result['token']);
      User.token = result['token'];
      User user = User.fromJson(result['user']);

      return user;
    });

    return response;
  }

  static Future<ApiReturnValue<User>> signUp({
    required String name,
    required String email,
    required String password,
    required String paswordConfirmation,
  }) async {
    String url = "$baseUrl/register";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: <String, dynamic>{
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": paswordConfirmation
        },
        errorMessage: "Failed to register. Please try again.",
      );

      await prefs.setString('token', result['access_token']);
      User.token = result['access_token'];
      User user = User.fromJson(result['user']);

      return user;
    });

    return response;
  }

  static Future<ApiReturnValue<User>> getUserByToken(
      {required String token}) async {
    String url = "$baseUrl/me";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
          url: url, token: token, errorMesssage: "Failed to get user");

      User.token = token;
      User user = User.fromJson(result['user']);

      return user;
    });

    return response;
  }
}

part of 'service.dart';

class LaundryService {
  static Future<ApiReturnValue<Laundry>> createLaundry() async {
    String url = "$baseUrl/stores/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        errorMessage: "Failed to create laundry",
      );

      Laundry laundry = Laundry.fromJson(result);

      return laundry;
    });

    return response;
  }
}

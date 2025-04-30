part of 'service.dart';

class LaundryService {
  static Future<ApiReturnValue<Laundry>> createLaundry(
      {required Map<String, dynamic> data,
      required File image,
      File? logo,
      File? qris}) async {
    String url = "$baseUrl/stores/create";
    List<Map<String, dynamic>> fields = [];
    List<Map<String, dynamic>> files = [];

    data.forEach((key, value) {
      if (value != null) {
        fields.add({key: value.toString()});
      }
    });
    files.add({"picture": image.path});
    if (logo != null) {
      files.add({"logo": logo.path});
    }
    if (qris != null) {
      files.add({"qris": qris.path});
    }

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.postDataWithImage(
        url: url,
        fields: fields,
        files: files,
        errorMessage: "Failed to create laundry",
      );

      print(result);

      Laundry laundry = Laundry.fromJson(result['data']['store']);

      return laundry;
    });

    return response;
  }
}

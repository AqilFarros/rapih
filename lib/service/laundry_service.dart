part of 'service.dart';

class LaundryService {
  static Future<ApiReturnValue<List<Laundry>>> getLaundry() async {
    String url = "$baseUrl/stores";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
          url: url, errorMesssage: "Failed to get laundry");

      List<Laundry> laundry =
          (result['data'] as Iterable).map((e) => Laundry.fromJson(e)).toList();

      return laundry;
    });

    return response;
  }

  static Future<ApiReturnValue<Laundry>> createLaundry(
      {required Map<String, dynamic> data,
      required File image,
      File? logo,
      File? qris}) async {
    String url = "$baseUrl/stores/create";
    List<Map<String, dynamic>> fields = [];
    List<Map<String, dynamic>> files = [];

    data.forEach((key, value) {
      if (value != "") {
        fields.add({key: value.toString()});
      }
    });

    print(fields);

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

      Laundry laundry = Laundry.fromJson(result['data']['store']);

      return laundry;
    });

    return response;
  }
}

part of 'service.dart';

class LayananService {
  static Future<ApiReturnValue<List<Layanan>>> getLayanan(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/layanan";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
          url: url, errorMessage: "Failed to get layanan");

      List<Layanan> layanan = (result['data'] as Iterable)
          .map((e) => Layanan.fromJson(e))
          .toList();

      return layanan;
    });

    return response;
  }

  static Future<ApiReturnValue<Layanan>> getLayananByid(
      {required int storeId, required int layananId}) async {
    String url = "$baseUrl/stores/$storeId/layanan/$layananId";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
          url: url, errorMessage: "Failed to get layanan");

      return Layanan.fromJson(result['data']);
    });

    return response;
  }

  static Future<ApiReturnValue<Layanan>> addLayanan(
      {required int storeId, required String name, required int duration,}) async {
    String url = "$baseUrl/stores/$storeId/layanan/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "duration": duration,
        },
        errorMessage: "Failed to add layanan",
      );

      Layanan layanan = Layanan.fromJson(result['data']);

      return layanan;
    });

    return response;
  }

  static Future<ApiReturnValue<Layanan>> editLayanan(
      {required int storeId,
      required int layananId,
      required String name, required int duration,}) async {
    String url = "$baseUrl/stores/$storeId/layanan/$layananId/update";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "duration": duration,
        },
        errorMessage: "Failed to edit layanan",
      );

      Layanan layanan = Layanan.fromJson(result['data']);

      return layanan;
    });

    return response;
  }

  static Future<ApiReturnValue<bool>> deleteLayanan({
    required int storeId,
    required int layananId,
  }) async {
    String url = "$baseUrl/stores/$storeId/layanan/$layananId/delete";

    var response = await ApiService.handleResponse(() async {
      await ApiService.delete(
        url: url,
        errorMessage: "Failed to delete layanan",
      );

      return true;
    });

    return response;
  }
}

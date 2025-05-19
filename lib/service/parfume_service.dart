part of 'service.dart';

class ParfumeService {
  static Future<ApiReturnValue<List<Parfume>>> getParfume(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/parfumes";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get parfume");

      List<Parfume> parfume =
          (result['data'] as Iterable).map((e) => Parfume.fromJson(e)).toList();

      return parfume;
    });

    return response;
  }

  static Future<ApiReturnValue<Parfume>> getParfumeById(
      {required int storeId, required int parfumeId}) async {
    String url = "$baseUrl/stores/$storeId/parfumes/$parfumeId";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get parfume");

      return Parfume.fromJson(result['data']);
    });

    return response;
  }

  static Future<ApiReturnValue<Parfume>> addParfume({
    required int storeId,
    required String name,
    required int price,
  }) async {
    String url = "$baseUrl/stores/$storeId/parfumes/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "price": price,
        },
        errorMessage: "Failed to add parfume",
      );

      Parfume parfume = Parfume.fromJson(result['data']);

      return parfume;
    });

    return response;
  }

  static Future<ApiReturnValue<Parfume>> editParfume({
    required int storeId,
    required int parfumeId,
    required String name,
    required int price,
  }) async {
    String url = "$baseUrl/stores/$storeId/parfumes/$parfumeId/update";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "price": price,
        },
        errorMessage: "Failed to edit parfume",
      );

      Parfume parfume = Parfume.fromJson(result['data']);

      return parfume;
    });

    return response;
  }

  static Future<ApiReturnValue<bool>> deleteParfume({
    required int storeId,
    required int parfumeId,
  }) async {
    String url = "$baseUrl/stores/$storeId/parfumes/$parfumeId/delete";

    var response = await ApiService.handleResponse(() async {
      await ApiService.delete(
        url: url,
        errorMessage: "Failed to delete parfume",
      );

      return true;
    });

    return response;
  }
}

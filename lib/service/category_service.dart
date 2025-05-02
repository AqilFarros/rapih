part of 'service.dart';

class CategoryService {
  static Future<ApiReturnValue<List<Category>>> getCategories({required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/categories";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
          url: url, errorMesssage: "Failed to get category");

      List<Category> category = (result['data'] as Iterable)
          .map((e) => Category.fromJson(e))
          .toList();

      return category;
    });

    return response;
  }
}

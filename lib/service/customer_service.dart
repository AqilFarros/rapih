part of 'service.dart';

class CustomerService {
  static Future<ApiReturnValue<List<Customer>>> getCustomer(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/customers";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
          url: url, errorMesssage: "Failed to get customer");

      List<Customer> customer = (result['data'] as Iterable)
          .map((e) => Customer.fromJson(e))
          .toList();

      return customer;
    });

    return response;
  }

  static Future<ApiReturnValue<Category>> addCategory(
      {required int storeId, required String name}) async {
    String url = "$baseUrl/stores/$storeId/categories/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
        },
        errorMessage: "Failed to add category",
      );

      Category category = Category.fromJson(result['data']);

      return category;
    });

    return response;
  }

  static Future<ApiReturnValue<Category>> editCategory(
      {required int storeId,
      required int categoryId,
      required String name}) async {
    String url = "$baseUrl/stores/$storeId/categories/$categoryId/update";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
        },
        errorMessage: "Failed to edit category",
      );

      Category category = Category.fromJson(result['data']);

      return category;
    });

    return response;
  }

  static Future<ApiReturnValue<bool>> deleteCategory({
    required int storeId,
    required int categoryId,
  }) async {
    String url = "$baseUrl/stores/$storeId/categories/$categoryId/delete";

    var response = await ApiService.handleResponse(() async {
      await ApiService.delete(
        url: url,
        errorMessage: "Failed to delete category",
      );

      return true;
    });

    return response;
  }
}
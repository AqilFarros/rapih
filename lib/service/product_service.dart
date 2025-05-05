part of 'service.dart';

class ProductService {
  static Future<ApiReturnValue<List<Product>>> getProducts(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/products";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
          url: url, errorMesssage: "Failed to get product");

      List<Product> product = (result['products'] as Iterable)
          .map((e) => Product.fromJson(e))
          .toList();

      return product;
    });

    return response;
  }

  static Future<ApiReturnValue<Product>> addProduct(
      {required int storeId, required String name, required int categoryId, required int price,}) async {
    String url = "$baseUrl/stores/$storeId/products/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "category_id": categoryId,
          "price": price,
        },
        errorMessage: "Failed to add product",
      );

      Product product = Product.fromJson(result['product']);

      return product;
    });

    return response;
  }

  static Future<ApiReturnValue<Product>> editProduct(
      {required int storeId,
      required int productId,
      required int categoryId,
      required String name,
      required int price,}) async {
    String url = "$baseUrl/stores/$storeId/products/$productId/update";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "category_id": categoryId,
          "price": price,
        },
        errorMessage: "Failed to edit product",
      );

      Product product = Product.fromJson(result['product']);

      return product;
    });

    return response;
  }

  static Future<ApiReturnValue<bool>> deleteProduct({
    required int storeId,
    required int productId,
  }) async {
    String url = "$baseUrl/stores/$storeId/products/$productId/delete";

    var response = await ApiService.handleResponse(() async {
      await ApiService.delete(
        url: url,
        errorMessage: "Failed to delete product",
      );

      return true;
    });

    return response;
  }
}
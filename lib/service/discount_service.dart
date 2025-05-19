part of 'service.dart';

class DiscountService {
  static Future<ApiReturnValue<List<Discount>>> getDiscount(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/discounts";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
        url: url,
        errorMessage: "Failed to get discount",
      );

      List<Discount> discounts = (result['discounts'] as Iterable)
          .map((item) => Discount.fromJson(item))
          .toList();

      return discounts;
    });

    return response;
  }

  static Future<ApiReturnValue<Discount>> getDiscountById(
      {required int storeId, required int discountId}) async {
    String url = "$baseUrl/stores/$storeId/discounts/$discountId";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
        url: url,
        errorMessage: "Failed to get discount",
      );

      return Discount.fromJson(result['discount']);
    });

    return response;
  }

  static Future<ApiReturnValue<Discount>> addDiscount(
      {required int storeId, required String name, required int amount}) async {
    String url = "$baseUrl/stores/$storeId/discounts/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "amount": amount,
        },
        errorMessage: "Failed to add discount",
      );

      Discount discount = Discount.fromJson(result['discount']);

      return discount;
    });

    return response;
  }

  static Future<ApiReturnValue<Discount>> editDiscount({
    required int storeId,
    required int discountId,
    required String name,
    required int amount,
  }) async {
    String url = "$baseUrl/stores/$storeId/discounts/$discountId/update";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "amount": amount,
        },
        errorMessage: "Failed to edit discount",
      );

      Discount discount = Discount.fromJson(result['discount']);

      return discount;
    });

    return response;
  }

  static Future<ApiReturnValue<bool>> deleteDiscount({
    required int storeId,
    required int discountId,
  }) async {
    String url = "$baseUrl/stores/$storeId/discounts/$discountId/delete";

    var response = await ApiService.handleResponse(() async {
      await ApiService.delete(
        url: url,
        errorMessage: "Failed to delete discount",
      );

      return true;
    });

    return response;
  }
}

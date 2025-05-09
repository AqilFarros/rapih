part of 'service.dart';

class CashierService {
  static Future<ApiReturnValue<List<Cashier>>> getCashier(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/kasirs";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get cashier");

      List<Cashier> cashier = (result['kasirs'] as Iterable)
          .map((item) => Cashier.fromJson(item))
          .toList();

      return cashier;
    });

    return response;
  }

  static Future<ApiReturnValue<Cashier>> addCashier(
      {required int storeId, required String email}) async {
    String url = "$baseUrl/stores/$storeId/kasirs/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {"email": email},
        errorMessage: "Cashier is not found. Pleas put a correct email",
      );

      Cashier cashier = Cashier.fromJson(result);

      return cashier;
    });

    return response;
  }

  static Future<ApiReturnValue<bool>> deleteCashier(
      {required int cashierId, required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/kasirs/$cashierId/delete";

    var response = await ApiService.handleResponse(() async {
      await ApiService.delete(
          url: url, errorMessage: "Failed to delete cashier");

      return true;
    });

    return response;
  }
}

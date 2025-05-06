part of 'service.dart';

class CustomerService {
  static Future<ApiReturnValue<List<Customer>>> getCustomer(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/customers";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
          url: url, errorMessage: "Failed to get customer");

      List<Customer> customer = (result['customers']['data'] as Iterable)
          .map((e) => Customer.fromJson(e))
          .toList();

      return customer;
    });

    return response;
  }

  static Future<ApiReturnValue<Customer>> addCustomer(
      {required int storeId, required String name, required String address, required int number}) async {
    String url = "$baseUrl/stores/$storeId/customers/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "address": address,
          "number": number.toString(),
        },
        errorMessage: "Failed to add customer",
      );

      Customer customer = Customer.fromJson(result['customer']);

      return customer;
    });

    return response;
  }
}
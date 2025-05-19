part of 'service.dart';

class OrderService {
  static Future<ApiReturnValue<List<Order>>> getOrders(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/pesanans";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get orders");

      var orders =
          Future.wait((result['data']['data'] as Iterable).map((item) async {
        ApiReturnValue<Order> order;
        order = await getOrderById(storeId: storeId, orderId: item['id']);
        return order.value!;
      }).toList());

      return orders;
    });

    return response;
  }

  static Future<ApiReturnValue<Order>> getOrderById(
      {required int storeId, required int orderId}) async {
    String url = "$baseUrl/stores/$storeId/pesanans/$orderId";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get order");

      return Order.fromJson(result['data']);
    });

    return response;
  }
}

part of 'service.dart';

class OrderService {
  static Future<ApiReturnValue<List<Order>>> getOrders(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/pesanans";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get orders");

      // print(result);

      List<Order> orders = await Future.wait(
          (result['data']['data'] as Iterable).map((item) async {
        ApiReturnValue<Order> order;
        order = await getOrderById(storeId: storeId, orderId: item['id']);
        // print(order.value);
        return order.value!;
      }).toList());

      // print(orders);

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

      Order order = Order.fromJson(result['data']);

      return order;
    });

    return response;
  }
}

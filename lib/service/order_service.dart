part of 'service.dart';

class OrderService {
  static Future<ApiReturnValue<List<Order>>> getOrders(
      {required int storeId, String? range}) async {
    String url = "$baseUrl/stores/$storeId/pesanans?range=${range ?? 'weekly'}";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get orders");

      List<Order> orders = await Future.wait(
          (result['data']['data'] as Iterable).map((item) async {
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

      Order order = Order.fromJson(result['data']);

      return order;
    });

    return response;
  }

  static Future<ApiReturnValue<Order>> createOrder({
    required int storeId,
    required int customerId,
    required int layananId,
    required List<SelectedProduct> products,
    required String paymentMethod,
    required bool isPaid,
    int? parfumeId,
    int? deliveryId,
    int? discountId,
  }) async {
    String url = "$baseUrl/stores/$storeId/pesanans/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "store_id": storeId,
          "customer_id": customerId,
          "layanan_id": layananId,
          "payment_method": paymentMethod.toLowerCase(),
          "is_paid": isPaid,
          "products": products
              .map((e) => {
                    "product_id": e.product.id,
                    "quantity": e.quantity,
                    "subtotal": e.quantity * e.product.price,
                  })
              .toList(),
              "parfume_id": parfumeId,
              "delivery_id": deliveryId,
              "discount_id": discountId,
        },
        errorMessage: "Failed to create order",
      );

      ApiReturnValue<Order> order =
          await getOrderById(storeId: storeId, orderId: result['data']['id']);

      return order.value!;
    });

    return response;
  }
}

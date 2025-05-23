part of 'service.dart';

class OrderService {
  static Future<ApiReturnValue<List<Order>>> getOrders(
      {required int storeId, String? range}) async {
    String url = "$baseUrl/stores/$storeId/pesanans?range=${range ?? ''}";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get orders");

      List<Order> orders = (result['data']['pesanans'] as Iterable)
          .map<Order>((item) => Order.fromJson(item))
          .toList();

      return orders;
    });

    return response;
  }

  static Future<ApiReturnValue<List<Order>>> getOrdersByQuery(
      {required int storeId, required String query}) async {
    String url = "$baseUrl/stores/$storeId/pesanans?search=$query";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get orders");

      List<Order> orders = (result['data']['pesanans'] as Iterable)
          .map<Order>((item) => Order.fromJson(item))
          .toList();

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
          "payment_method": paymentMethod == "E-Wallet"
              ? "ewallet"
              : paymentMethod.toLowerCase(),
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

  static Future<ApiReturnValue<String>> updateStatus(
      {required int storeId,
      required int orderId,
      required String status}) async {
    String url = "$baseUrl/stores/$storeId/pesanans/$orderId/update-status";

    var response = await ApiService.handleResponse(() async {
      await ApiService.post(
          url: url,
          body: {
            "status": status,
          },
          errorMessage: "Failed to update status");

      return status;
    });

    return response;
  }

  static Future<ApiReturnValue<String>> completedOrder(
      {required int storeId, required int orderId}) async {
    String url = "$baseUrl/stores/$storeId/pesanans/$orderId/completed";

    var response = await ApiService.handleResponse(() async {
      await ApiService.put(url: url, errorMessage: "Failed to complete order");

      return "completed";
    });

    return response;
  }
}

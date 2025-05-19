part of 'service.dart';

class DeliveryService {
  static Future<ApiReturnValue<List<Delivery>>> getDelivery(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/deliveries";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
        url: url,
        errorMessage: "Failed to get delivery",
      );

      List<Delivery> deliveries = (result['deliveries'] as Iterable)
          .map((item) => Delivery.fromJson(item))
          .toList();

      return deliveries;
    });

    return response;
  }

  static Future<ApiReturnValue<Delivery>> getDeliveryById(
      {required int storeId, required int deliveryId}) async {
    String url = "$baseUrl/stores/$storeId/deliveries/$deliveryId";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
        url: url,
        errorMessage: "Failed to get delivery",
      );

      return Delivery.fromJson(result['delivery']);
    });

    return response;
  }

  static Future<ApiReturnValue<Delivery>> addDelivery(
      {required int storeId, required String name, required int amount}) async {
    String url = "$baseUrl/stores/$storeId/deliveries/create";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "amount": amount,
        },
        errorMessage: "Failed to add delivery",
      );

      Delivery delivery = Delivery.fromJson(result['delivery']);

      return delivery;
    });

    return response;
  }

  static Future<ApiReturnValue<Delivery>> editDelivery(
      {required int storeId,
      required int deliveryId,
      required String name, required int amount,}) async {
    String url = "$baseUrl/stores/$storeId/deliveries/$deliveryId/update";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.post(
        url: url,
        body: {
          "name": name,
          "amount": amount,
        },
        errorMessage: "Failed to edit delivery",
      );

      Delivery delivery = Delivery.fromJson(result['delivery']);

      return delivery;
    });

    return response;
  }

  static Future<ApiReturnValue<bool>> deleteDelivery({
    required int storeId,
    required int deliveryId,
  }) async {
    String url = "$baseUrl/stores/$storeId/deliveries/$deliveryId/delete";

    var response = await ApiService.handleResponse(() async {
      await ApiService.delete(
        url: url,
        errorMessage: "Failed to delete delivery",
      );

      return true;
    });

    return response;
  }
}

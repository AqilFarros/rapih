import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future<void> getOrder({required int storeId, String? range}) async {
    emit(OrderInitial());

    ApiReturnValue<List<Order>> result =
        await OrderService.getOrders(storeId: storeId, range: range);

    if (result.value != null) {
      emit(OrderLoaded(result.value!));
    } else {
      emit(OrderLoadedFailed(result.message!));
    }
  }

  Future<void> getOrderById(
      {required int storeId, required int orderId}) async {
    List<Order> currentOrder =
        (state is OrderLoaded) ? (state as OrderLoaded).orders : [];

    emit(OrderInitial());

    ApiReturnValue<Order> result =
        await OrderService.getOrderById(storeId: storeId, orderId: orderId);

    if (result.value != null) {
      List<Order> order = currentOrder.map((item) {
        if (item.id == orderId) {
          return result.value!;
        } else {
          return item;
        }
      }).toList();

      emit(OrderLoaded(order));
    } else {
      emit(OrderLoadedFailed(result.message!));
    }
  }

  Future<void> createOrder({
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
    ApiReturnValue<Order> result = await OrderService.createOrder(
      storeId: storeId,
      customerId: customerId,
      layananId: layananId,
      products: products,
      paymentMethod: paymentMethod,
      isPaid: isPaid,
      parfumeId: parfumeId,
      deliveryId: deliveryId,
      discountId: discountId,
    );

    if (result.value != null) {
      List<Order> currentOrder =
          (state is OrderLoaded) ? (state as OrderLoaded).orders : [];

      List<Order> updatedOrderList = List.from(currentOrder)
        ..insert(0, result.value!);

      emit(OrderLoaded(updatedOrderList));
    } else {
      emit(OrderLoadedFailed(result.message!));
    }
  }

  Future<void> updateStatus({
    required int storeId,
    required int orderId,
    required String status,
  }) async {
    ApiReturnValue<String> result = await OrderService.updateStatus(
      storeId: storeId,
      orderId: orderId,
      status: status,
    );

    if (result.value != null) {
      List<Order> currentOrder =
          (state is OrderLoaded) ? (state as OrderLoaded).orders : [];

      List<Order> updatedOrderList = currentOrder.map((item) {
        if (item.id == orderId) {
          return item.copyWith(status: status);
        } else {
          return item;
        }
      }).toList();

      emit(OrderLoaded(updatedOrderList));
    } else {
      emit(OrderLoadedFailed(result.message!));
    }
  }

  Future<void> completedOrder({
    required int storeId,
    required int orderId,
  }) async {
    ApiReturnValue<String> result = await OrderService.completedOrder(
      storeId: storeId,
      orderId: orderId,
    );

    if (result.value != null) {
      List<Order> currentOrder =
          (state is OrderLoaded) ? (state as OrderLoaded).orders : [];

      List<Order> updatedOrderList = currentOrder.map((item) {
        if (item.id == orderId) {
          return item.copyWith(status: result.value);
        } else {
          return item;
        }
      }).toList();

      emit(OrderLoaded(updatedOrderList));
    } else {
      emit(OrderLoadedFailed(result.message!));
    }
  }
}

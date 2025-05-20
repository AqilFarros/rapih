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
}

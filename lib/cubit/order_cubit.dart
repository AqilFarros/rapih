import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future<void> getOrder({required int storeId}) async {
    ApiReturnValue<List<Order>> result =
        await OrderService.getOrders(storeId: storeId);

    if (result.value != null) {
      emit(OrderLoaded(result.value!));
    } else {
      emit(OrderLoadedFailed(result.message!));
    }
  }
}

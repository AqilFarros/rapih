import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'order_query_state.dart';

class OrderQueryCubit extends Cubit<OrderQueryState> {
  OrderQueryCubit() : super(OrderQueryInitial());

  Future<void> emitInitial() async {
    emit(const OrderQueryLoadedFailed(''));
  }

  Future<void> getOrderByQuery(
      {required int storeId, required String query}) async {
    emit(OrderQueryInitial());
    ApiReturnValue<List<Order>> result =
        await OrderService.getOrdersByQuery(storeId: storeId, query: query);

    if (result.value != null) {
      emit(OrderQueryLoaded(result.value!));
    } else {
      emit(OrderQueryLoadedFailed(result.message!));
    }
  }
}

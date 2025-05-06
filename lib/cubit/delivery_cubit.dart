import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial());

  Future<void> getDelivery({required int storeId}) async {
    ApiReturnValue<List<Delivery>> result =
        await DeliveryService.getDelivery(storeId: storeId);

    if (result.value != null) {
      emit(DeliveryLoaded(result.value!));
    } else {
      emit(DeliveryLoadedFailed(result.message!));
    }
  }

  Future<void> addDelivery({
    required int storeId,
    required String name,
    required int amount,
  }) async {
    ApiReturnValue<Delivery> result = await DeliveryService.addDelivery(
        storeId: storeId, name: name, amount: amount);

    if (result.value != null) {
      List<Delivery> currentDelivery =
          (state is DeliveryLoaded) ? (state as DeliveryLoaded).delivery : [];

      List<Delivery> updatedDeliveryList = List.from(currentDelivery)
        ..insert(0, result.value!);

      emit(DeliveryLoaded(updatedDeliveryList));
    } else {
      emit(DeliveryLoadedFailed(result.message!));
    }
  }

  Future<void> editDelivery({
    required int storeId,
    required int deliveryId,
    required String name,
    required int amount,
  }) async {
    ApiReturnValue<Delivery> result = await DeliveryService.editDelivery(
        storeId: storeId, deliveryId: deliveryId, name: name, amount: amount);

    if (result.value != null) {
      final currentState = state as DeliveryLoaded;
      final updatedDeliveryList = currentState.delivery.map((item) {
        if (item.id == result.value!.id) {
          return result.value!;
        } else {
          return item;
        }
      }).toList();

      emit(DeliveryLoaded(updatedDeliveryList));
    } else {
      emit(DeliveryLoadedFailed(result.message!));
    }
  }

  Future<void> deleteDelivery(
      {required int storeId, required int deliveryId}) async {
    ApiReturnValue<bool> result = await DeliveryService.deleteDelivery(
        storeId: storeId, deliveryId: deliveryId);

    if (result.value != null) {
      final currentState = state as DeliveryLoaded;
      final updatedDeliveryList =
          currentState.delivery.where((item) => item.id != deliveryId).toList();
      emit(DeliveryLoaded(updatedDeliveryList));
    } else {
      emit(DeliveryLoadedFailed(result.message!));
    }
  }
}

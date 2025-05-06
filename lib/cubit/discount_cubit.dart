import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'discount_state.dart';

class DiscountCubit extends Cubit<DiscountState> {
  DiscountCubit() : super(DiscountInitial());

  Future<void> getDiscount({required int storeId}) async {
    ApiReturnValue<List<Discount>> result =
        await DiscountService.getDiscount(storeId: storeId);

    if (result.value != null) {
      emit(DiscountLoaded(result.value!));
    } else {
      emit(DiscountLoadedFailed(result.message!));
    }
  }

  Future<void> addDiscount({
    required int storeId,
    required String name,
    required int amount,
  }) async {
    ApiReturnValue<Discount> result = await DiscountService.addDiscount(
        storeId: storeId, name: name, amount: amount);

    if (result.value != null) {
      List<Discount> currentDiscount =
          (state is DiscountLoaded) ? (state as DiscountLoaded).discount : [];

      List<Discount> updatedDiscountList = List.from(currentDiscount)
        ..insert(0, result.value!);

      emit(DiscountLoaded(updatedDiscountList));
    } else {
      emit(DiscountLoadedFailed(result.message!));
    }
  }

  Future<void> editDiscount({
    required int storeId,
    required int discountId,
    required String name,
    required int amount,
  }) async {
    ApiReturnValue<Discount> result = await DiscountService.editDiscount(
        storeId: storeId, discountId: discountId, name: name, amount: amount);

    if (result.value != null) {
      final currentState = state as DiscountLoaded;
      final updatedDiscountList = currentState.discount.map((item) {
        if (item.id == result.value!.id) {
          return result.value!;
        } else {
          return item;
        }
      }).toList();

      emit(DiscountLoaded(updatedDiscountList));
    } else {
      emit(DiscountLoadedFailed(result.message!));
    }
  }

  Future<void> deleteDiscount({
    required int storeId,
    required int discountId,
  }) async {
    ApiReturnValue<bool> result = await DiscountService.deleteDiscount(
        storeId: storeId, discountId: discountId);

    if (result.value != null) {
      final currentState = state as DiscountLoaded;
      final updatedDiscountList =
          currentState.discount.where((item) => item.id != discountId).toList();
      emit(DiscountLoaded(updatedDiscountList));
    } else {
      emit(DiscountLoadedFailed(result.message!));
    }
  }
}

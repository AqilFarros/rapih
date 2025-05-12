import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  CashierCubit() : super(CashierInitial());

  Future<void> getCashier({required int storeId}) async {
    ApiReturnValue<List<Cashier>> result =
        await CashierService.getCashier(storeId: storeId);

    if (result.value != null) {
      emit(CashierLoaded(result.value!));
    } else {
      emit(CashierLoadedFailed(result.message!));
    }
  }

  Future<void> addCashier({required int storeId, required String email}) async {
    ApiReturnValue<Cashier> result =
        await CashierService.addCashier(storeId: storeId, email: email);

    if (result.value != null) {
      List<Cashier> currentCashier =
          (state is CashierLoaded) ? (state as CashierLoaded).cashier : [];

      List<Cashier> updatedCashierList = List.from(currentCashier)
        ..insert(0, result.value!);

      emit(CashierLoaded(updatedCashierList));
    } else {
      emit(CashierLoadedFailed(result.message!));
    }
  }

  Future<void> editCashier(
      {required int storeId,
      required int cashierId,
      required bool status}) async {
    ApiReturnValue<Cashier> result = await CashierService.editCashier(
      storeId: storeId,
      cashierId: cashierId,
      status: status,
    );

    if (result.value != null) {
      final currentState = state as CashierLoaded;
      final updatedCashierList = currentState.cashier
          .map((item) => item.id == cashierId ? result.value! : item)
          .toList();
      emit(CashierLoaded(updatedCashierList));
    } else {
      emit(CashierLoadedFailed(result.message!));
    }
  }

  Future<void> deleteCashier(
      {required int storeId, required int cashierId}) async {
    ApiReturnValue<bool> result = await CashierService.deleteCashier(
        storeId: storeId, cashierId: cashierId);

    if (result.value != null) {
      final currentState = state as CashierLoaded;
      final updatedCashierList =
          currentState.cashier.where((item) => item.id != cashierId).toList();
      emit(CashierLoaded(updatedCashierList));
    } else {
      emit(CashierLoadedFailed(result.message!));
    }
  }
}

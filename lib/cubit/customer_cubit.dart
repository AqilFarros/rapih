import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial());

  Future<void> getCustomer({required int storeId}) async {
    ApiReturnValue<List<Customer>> result =
        await CustomerService.getCustomer(storeId: storeId);

    if (result.value != null) {
      emit(CustomerLoaded(result.value!));
    } else {
      emit(CustomerLoadedFailed(result.message!));
    }
  }

  Future<void> addCustomer(
      {required int storeId,
      required String name,
      required String address,
      required int number}) async {
    ApiReturnValue<Customer> result = await CustomerService.addCustomer(
        storeId: storeId, name: name, address: address, number: number);

    if (result.value != null) {
      List<Customer> currentCustomer =
          (state is CustomerLoaded) ? (state as CustomerLoaded).customer : [];

      List<Customer> updatedCustomerList = List.from(currentCustomer)
        ..insert(0, result.value!);

      emit(CustomerLoaded(updatedCustomerList));
    } else {
      emit(CustomerLoadedFailed(result.message!));
    }
  }
}

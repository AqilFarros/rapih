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
}

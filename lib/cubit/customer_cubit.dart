import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial());
}

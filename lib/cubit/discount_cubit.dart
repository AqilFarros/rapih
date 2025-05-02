import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'discount_state.dart';

class DiscountCubit extends Cubit<DiscountState> {
  DiscountCubit() : super(DiscountInitial());
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'parfume_state.dart';

class ParfumeCubit extends Cubit<ParfumeState> {
  ParfumeCubit() : super(ParfumeInitial());
}

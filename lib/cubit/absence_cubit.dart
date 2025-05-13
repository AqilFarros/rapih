import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'absence_state.dart';

class AbsenceCubit extends Cubit<AbsenceState> {
  AbsenceCubit() : super(AbsenceInitial());

  Future<void> getAbsence(
      {required int storeId, String? startDate, String? endDate}) async {
    emit(AbsenceInitial());
    ApiReturnValue<Absence> result = await AbsenceService()
        .getAbsence(storeId: storeId, start: startDate, end: endDate);

    if (result.value != null) {
      emit(AbsenceLoaded(result.value!));
    } else {
      emit(AbsenceLoadedFailed(result.message!));
    }
  }
}

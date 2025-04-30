import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'laundry_state.dart';

class LaundryCubit extends Cubit<LaundryState> {
  LaundryCubit() : super(LaundryInitial());

  Future<void> getLaundry() async {}

  Future<void> createLaundry(
      {required Map<String, dynamic> data,
      required File image,
      File? logo,
      File? qris}) async {
    ApiReturnValue<Laundry> result = await LaundryService.createLaundry(
      data: data,
      image: image,
      logo: logo,
      qris: qris,
    );

    if (result.value != null) {
      emit(LaundryLoaded((state as LaundryLoaded).laundry + [result.value!]));
    } else {
      emit(LaundryLoadedFailed(result.message!));
    }
  }
}

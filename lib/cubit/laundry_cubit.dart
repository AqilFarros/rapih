import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'laundry_state.dart';

class LaundryCubit extends Cubit<LaundryState> {
  LaundryCubit() : super(LaundryInitial());

  Future<void> getLaundry() async {
    ApiReturnValue<List<Laundry>> result = await LaundryService.getLaundry();

    if (result.value != null) {
      emit(LaundryLoaded(result.value!));
    } else {
      emit(LaundryLoadedFailed(result.message!));
    }
  }

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
    List<Laundry> currentLaundry = (state is LaundryLoaded) ? (state as LaundryLoaded).laundry : [];

    List<Laundry> updatedLaundryList = List.from(currentLaundry)..add(result.value!);

    emit(LaundryLoaded(updatedLaundryList));
  } else {
    emit(LaundryLoadedFailed(result.message!));
  }
  }
}

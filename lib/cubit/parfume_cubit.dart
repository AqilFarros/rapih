import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'parfume_state.dart';

class ParfumeCubit extends Cubit<ParfumeState> {
  ParfumeCubit() : super(ParfumeInitial());

  Future<void> getParfume({required int storeId}) async {
    ApiReturnValue<List<Parfume>> result =
        await ParfumeService.getParfume(storeId: storeId);

    if (result.value != null) {
      emit(ParfumeLoaded(result.value!));
    } else {
      emit(ParfumeLoadedFailed(result.message!));
    }
  }

  Future<void> addParfume({
    required int storeId,
    required String name,
    required int price,
  }) async {
    ApiReturnValue<Parfume> result = await ParfumeService.addParfume(
        storeId: storeId, name: name, price: price);

    if (result.value != null) {
      List<Parfume> currentParfume =
          (state is ParfumeLoaded) ? (state as ParfumeLoaded).parfume : [];

      List<Parfume> updatedParfumeList = List.from(currentParfume)
        ..insert(0, result.value!);

      emit(ParfumeLoaded(updatedParfumeList));
    } else {
      emit(ParfumeLoadedFailed(result.message!));
    }
  }

  Future<void> editParfume({
    required int storeId,
    required int parfumeId,
    required String name,
    required int price,
  }) async {
    ApiReturnValue<Parfume> result = await ParfumeService.editParfume(
        storeId: storeId, parfumeId: parfumeId, name: name, price: price);

    if (result.value != null) {
      final currentState = state as ParfumeLoaded;
      final updatedParfumeList = currentState.parfume.map((item) {
        if (item.id == result.value!.id) {
          return result.value!;
        } else {
          return item;
        }
      }).toList();

      emit(ParfumeLoaded(updatedParfumeList));
    } else {
      emit(ParfumeLoadedFailed(result.message!));
    }
  }

  Future<void> deleteParfume({
    required int storeId,
    required int parfumeId,
  }) async {
    ApiReturnValue<bool> result = await ParfumeService.deleteParfume(
        storeId: storeId, parfumeId: parfumeId);

    if (result.value != null) {
      final currentState = state as ParfumeLoaded;
      final updatedParfumeList =
          currentState.parfume.where((item) => item.id != parfumeId).toList();
      emit(ParfumeLoaded(updatedParfumeList));
    } else {
      emit(ParfumeLoadedFailed(result.message!));
    }
  }
}

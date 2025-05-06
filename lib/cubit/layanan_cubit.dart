import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'layanan_state.dart';

class LayananCubit extends Cubit<LayananState> {
  LayananCubit() : super(LayananInitial());

  Future<void> getLayanan({required int storeId}) async {
    ApiReturnValue<List<Layanan>> result =
        await LayananService.getLayanan(storeId: storeId);

    if (result.value != null) {
      emit(LayananLoaded(result.value!));
    } else {
      emit(LayananLoadedFailed(result.message!));
    }
  }

  Future<void> addLayanan({
    required int storeId,
    required String name,
    required int duration,
  }) async {
    ApiReturnValue<Layanan> result = await LayananService.addLayanan(
        storeId: storeId, name: name, duration: duration);

    if (result.value != null) {
      List<Layanan> currentLayanan =
          (state is LayananLoaded) ? (state as LayananLoaded).layanan : [];

      List<Layanan> updatedLayananList = List.from(currentLayanan)
        ..insert(0, result.value!);

      emit(LayananLoaded(updatedLayananList));
    } else {
      emit(LayananLoadedFailed(result.message!));
    }
  }

  Future<void> editLayanan({
    required int storeId,
    required int layananId,
    required String name,
    required int duration,
  }) async {
    ApiReturnValue<Layanan> result = await LayananService.editLayanan(
        storeId: storeId, layananId: layananId, name: name, duration: duration);

    if (result.value != null) {
      final currentState = state as LayananLoaded;
      final updatedLayananList = currentState.layanan.map((item) {
        if (item.id == result.value!.id) {
          return result.value!;
        } else {
          return item;
        }
      }).toList();

      emit(LayananLoaded(updatedLayananList));
    } else {
      emit(LayananLoadedFailed(result.message!));
    }
  }

  Future<void> deleteLayanan({
    required int storeId,
    required int layananId,
  }) async {
    ApiReturnValue<bool> result = await LayananService.deleteLayanan(
        storeId: storeId, layananId: layananId);

    if (result.value != null) {
      final currentState = state as LayananLoaded;
      final updatedLayananList =
          currentState.layanan.where((item) => item.id != layananId).toList();
      emit(LayananLoaded(updatedLayananList));
    } else {
      emit(LayananLoadedFailed(result.message!));
    }
  }
}

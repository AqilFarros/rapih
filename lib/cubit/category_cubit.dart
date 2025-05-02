import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future<void> getCategory({required int storeId}) async {
    ApiReturnValue<List<Category>> result = await CategoryService.getCategories(storeId: storeId);

    if (result.value != null) {
      emit(CategoryLoaded(result.value!));
    } else {
      emit(CategoryLoadedFailed(result.message!));
    }
  }
}

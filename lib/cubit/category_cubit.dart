import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  Future<void> getCategory({required int storeId}) async {
    ApiReturnValue<List<Category>> result =
        await CategoryService.getCategories(storeId: storeId);

    if (result.value != null) {
      emit(CategoryLoaded(result.value!));
    } else {
      emit(CategoryLoadedFailed(result.message!));
    }
  }

  Future<void> addCategory({required int storeId, required String name}) async {
    ApiReturnValue<Category> result =
        await CategoryService.addCategory(storeId: storeId, name: name);

    if (result.value != null) {
      List<Category> currentCategory =
          (state is CategoryLoaded) ? (state as CategoryLoaded).category : [];

      List<Category> updatedCategoryList = List.from(currentCategory)
        ..insert(0,result.value!);

      emit(CategoryLoaded(updatedCategoryList));
    } else {
      emit(CategoryLoadedFailed(result.message!));
    }
  }

  Future<void> editCategory(
      {required int storeId,
      required int categoryId,
      required String name}) async {
    ApiReturnValue<Category> result = await CategoryService.editCategory(
        storeId: storeId, categoryId: categoryId, name: name);

    if (result.value != null) {
      final currentState = state as CategoryLoaded;
      final updatedCategoryList = currentState.category.map((item) {
        if (item.id == result.value!.id) {
          return result.value!;
        } else {
          return item;
        }
      }).toList();

      emit(CategoryLoaded(updatedCategoryList));
    } else {
      emit(CategoryLoadedFailed(result.message!));
    }
  }

  Future<void> deleteCategory(
      {required int storeId, required int categoryId}) async {
    ApiReturnValue<bool> result = await CategoryService.deleteCategory(
        storeId: storeId, categoryId: categoryId);

    if (result.value != null) {
      final currentState = state as CategoryLoaded;
      final updatedCategoryList =
          currentState.category.where((item) => item.id != categoryId).toList();
      emit(CategoryLoaded(updatedCategoryList));
    } else {
      emit(CategoryLoadedFailed(result.message!));
    }
  }
}

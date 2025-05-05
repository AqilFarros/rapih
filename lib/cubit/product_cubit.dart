import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> getProduct({required int storeId}) async {
    ApiReturnValue<List<Product>> result =
        await ProductService.getProducts(storeId: storeId);

    if (result.value != null) {
      emit(ProductLoaded(result.value!));
    } else {
      emit(ProductLoadedFailed(result.message!));
    }
  }

  Future<void> addProduct({required int storeId, required int categoryId,required String name, required int price,}) async {
    ApiReturnValue<Product> result =
        await ProductService.addProduct(storeId: storeId, name: name, categoryId: categoryId, price: price);

    if (result.value != null) {
      List<Product> currentProduct =
          (state is ProductLoaded) ? (state as ProductLoaded).product : [];

      List<Product> updatedProductList = List.from(currentProduct)
        ..add(result.value!);

      emit(ProductLoaded(updatedProductList));
    } else {
      emit(ProductLoadedFailed(result.message!));
    }
  }

  Future<void> editProduct(
      {required int storeId,
      required int categoryId,
      required int productId,
      required String name,
      required int price,}) async {
    ApiReturnValue<Product> result = await ProductService.editProduct(
        storeId: storeId, productId: productId, name: name, categoryId: categoryId, price: price);

    if (result.value != null) {
      final currentState = state as ProductLoaded;
      final updatedProductList = currentState.product.map((item) {
        if (item.id == result.value!.id) {
          return result.value!;
        } else {
          return item;
        }
      }).toList();

      emit(ProductLoaded(updatedProductList));
    } else {
      emit(ProductLoadedFailed(result.message!));
    }
  }

  Future<void> deleteProduct(
      {required int storeId, required int productId}) async {
    ApiReturnValue<bool> result = await ProductService.deleteProduct(
        storeId: storeId, productId: productId);

    if (result.value != null) {
      final currentState = state as ProductLoaded;
      final updatedProductList =
          currentState.product.where((item) => item.id != productId).toList();
      emit(ProductLoaded(updatedProductList));
    } else {
      emit(ProductLoadedFailed(result.message!));
    }
  }
}

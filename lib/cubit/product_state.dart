part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<Product> product;

  const ProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}

final class ProductLoadedFailed extends ProductState {
  final String message;

  const ProductLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

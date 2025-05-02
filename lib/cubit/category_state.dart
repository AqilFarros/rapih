part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<Category> category;

  const CategoryLoaded(this.category);

  @override
  List<Object> get props => [category];
}

final class CategoryLoadedFailed extends CategoryState {
  final String message;

  const CategoryLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

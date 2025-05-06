part of 'discount_cubit.dart';

sealed class DiscountState extends Equatable {
  const DiscountState();

  @override
  List<Object> get props => [];
}

final class DiscountInitial extends DiscountState {}

final class DiscountLoaded extends DiscountState {
  final List<Discount> discount;

  const DiscountLoaded(this.discount);

  @override
  List<Object> get props => [discount];
}

final class DiscountLoadedFailed extends DiscountState {
  final String message;

  const DiscountLoadedFailed(this.message);

  @override
  List<Object> get props => [message];

}

part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoaded extends OrderState {
  final List<Order> orders;

  const OrderLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

final class OrderLoadedFailed extends OrderState {
  final String message;

  const OrderLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

part of 'order_query_cubit.dart';

sealed class OrderQueryState extends Equatable {
  const OrderQueryState();

  @override
  List<Object> get props => [];
}

final class OrderQueryInitial extends OrderQueryState {}

final class OrderQueryLoaded extends OrderQueryState {
  final List<Order> orders;

  const OrderQueryLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

final class OrderQueryLoadedFailed extends OrderQueryState {
  final String message;

  const OrderQueryLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

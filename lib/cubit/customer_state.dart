part of 'customer_cubit.dart';

sealed class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

final class CustomerInitial extends CustomerState {}

final class CustomerLoaded extends CustomerState {
  final List<Customer> customer;

  const CustomerLoaded(this.customer);

  @override
  List<Object> get props => [customer];
}

final class CustomerLoadedFailed extends CustomerState {
  final String message;

  const CustomerLoadedFailed(this.message);

  @override
  List<Object> get props => [message];

}

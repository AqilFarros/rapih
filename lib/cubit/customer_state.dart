part of 'customer_cubit.dart';

sealed class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

final class CustomerInitial extends CustomerState {}

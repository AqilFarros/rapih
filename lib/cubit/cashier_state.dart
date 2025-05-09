part of 'cashier_cubit.dart';

sealed class CashierState extends Equatable {
  const CashierState();

  @override
  List<Object> get props => [];
}

final class CashierInitial extends CashierState {}

final class CashierLoaded extends CashierState {
  final List<Cashier> cashier;

  const CashierLoaded(this.cashier);

  @override
  List<Object> get props => [cashier];
}

final class CashierLoadedFailed extends CashierState {
  final String message;

  const CashierLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

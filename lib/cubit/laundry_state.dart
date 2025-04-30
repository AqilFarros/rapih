part of 'laundry_cubit.dart';

sealed class LaundryState extends Equatable {
  const LaundryState();

  @override
  List<Object> get props => [];
}

final class LaundryInitial extends LaundryState {
  @override
  List<Object> get props => [];
}

final class LaundryLoaded extends LaundryState {
  final List<Laundry> laundry;

  const LaundryLoaded(this.laundry);

  @override
  List<Object> get props => [laundry];
}

final class LaundryLoadedFailed extends LaundryState {
  final String message;

  const LaundryLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

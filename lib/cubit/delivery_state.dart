part of 'delivery_cubit.dart';

sealed class DeliveryState extends Equatable {
  const DeliveryState();

  @override
  List<Object> get props => [];
}

final class DeliveryInitial extends DeliveryState {}

final class DeliveryLoaded extends DeliveryState {
  final List<Delivery> delivery;

  const DeliveryLoaded(this.delivery);

  @override
  List<Object> get props => [delivery];
}

final class DeliveryLoadedFailed extends DeliveryState {
  final String message;

  const DeliveryLoadedFailed(this.message);

  @override
  List<Object> get props => [message];

}

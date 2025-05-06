part of 'parfume_cubit.dart';

sealed class ParfumeState extends Equatable {
  const ParfumeState();

  @override
  List<Object> get props => [];
}

final class ParfumeInitial extends ParfumeState {}

final class ParfumeLoaded extends ParfumeState {
  final List<Parfume> parfume;

  const ParfumeLoaded(this.parfume);

  @override
  List<Object> get props => [parfume];
}

final class ParfumeLoadedFailed extends ParfumeState {
  final String message;

  const ParfumeLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

part of 'layanan_cubit.dart';

sealed class LayananState extends Equatable {
  const LayananState();

  @override
  List<Object> get props => [];
}

final class LayananInitial extends LayananState {}

final class LayananLoaded extends LayananState {
  final List<Layanan> layanan;

  const LayananLoaded(this.layanan);

  @override
  List<Object> get props => [layanan];
}

final class LayananLoadedFailed extends LayananState {
  final String message;

  const LayananLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

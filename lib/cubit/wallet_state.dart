part of 'wallet_cubit.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

final class WalletInitial extends WalletState {
  @override
  List<Object> get props => [];
}

final class WalletLoaded extends WalletState {
  final Wallet wallet;

  const WalletLoaded(this.wallet);

  @override
  List<Object> get props => [wallet];
}

final class WalletLoadedFailed extends WalletState {
  final String message;

  const WalletLoadedFailed(this.message);

  @override
  List<Object> get props => [message];
}

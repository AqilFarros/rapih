import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rapih/model/model.dart';
import 'package:rapih/service/service.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  Future<void> getWallet({required int storeId}) async {
    ApiReturnValue<Wallet> result =
        await WalletService.getWallet(storeId: storeId);

    if (result.value != null) {
      emit(WalletLoaded(result.value!));
    } else {
      emit(WalletLoadedFailed(result.message!));
    }
  }
}

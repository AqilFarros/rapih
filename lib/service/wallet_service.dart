part of 'service.dart';

class WalletService {
  static Future<ApiReturnValue<Wallet>> getWallet(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/wallet";

    var response = ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get wallet");

      Wallet wallet = Wallet.fromJson(result);

      return wallet;
    });

    return response;
  }
}

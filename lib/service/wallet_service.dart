part of 'service.dart';

class WalletService {
  static Future<ApiReturnValue<Wallet>> getWallet(
      {required int storeId}) async {
    String url = "$baseUrl/stores/$storeId/wallet";

    var response = ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMesssage: "Failed to get wallet");

      Wallet wallet = Wallet.fromJson(result, result['wallet']);

      return wallet;
    });

    return response;
  }
}

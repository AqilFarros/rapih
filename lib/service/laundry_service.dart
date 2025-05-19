part of 'service.dart';

class LaundryService {
  static Future<ApiReturnValue<List<Laundry>>> getLaundry() async {
    String url = "$baseUrl/stores";

    var response = await ApiService.handleResponse(() async {
      var result =
          await ApiService.get(url: url, errorMessage: "Failed to get laundry");

      List<Laundry> laundry =
          await Future.wait((result['data'] as Iterable).map((e) async {
        Laundry laundry = Laundry.fromJson(e['store']);
        ApiReturnValue<Wallet> wallet =
            await WalletService.getWallet(storeId: e['store']['id']);
        laundry = laundry.copyWith(wallet: wallet.value);

        return laundry;
      }).toList());

      return laundry;
    });

    return response;
  }

  static Future<ApiReturnValue<Laundry>> createLaundry(
      {required Map<String, dynamic> data,
      required File image,
      File? logo,
      File? qris}) async {
    String url = "$baseUrl/stores/create";
    List<Map<String, dynamic>> fields = [];
    List<Map<String, dynamic>> files = [];

    data.forEach((key, value) {
      if (value != "") {
        fields.add({key: value.toString()});
      }
    });

    files.add({"picture": image.path});
    if (logo != null) {
      files.add({"logo": logo.path});
    }
    if (qris != null) {
      files.add({"qris": qris.path});
    }

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.postDataWithImage(
        url: url,
        fields: fields,
        files: files,
        errorMessage: "Failed to create laundry",
      );

      Laundry laundry = Laundry.fromJson(result['data']['store']);
      ApiReturnValue<Wallet> wallet =
          await WalletService.getWallet(storeId: laundry.id);
      laundry = laundry.copyWith(wallet: wallet.value);

      return laundry;
    });

    return response;
  }
}

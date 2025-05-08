part of 'service.dart';

class AbsenceService {
  Future<ApiReturnValue<bool>> cashierAttend(
      {required int storeId, required File image}) async {
    String url = "$baseUrl/store/$storeId/absensi";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.postDataWithImage(
        url: url,
        fields: [
          {"status": "hadir"}
        ],
        files: [
          {"foto_path": image.path}
        ],
        errorMessage: "Failed to attend",
      );

      print(result);

      return true;
    });

    return response;
  }
}

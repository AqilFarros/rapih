part of 'service.dart';

class AbsenceService {
  Future<ApiReturnValue<bool>> checkAbsence({required int storeId}) async {
    String url = "$baseUrl/store/$storeId/absensi-kasir/check-today";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
        url: url,
        errorMessage: "Failed to check absence",
      );

      if (result['sudah_absen'] == true) {
        return true;
      } else {
        return false;
      }
    });

    return response;
  }

  Future<ApiReturnValue<bool>> cashierAttend(
      {required int storeId, required File image}) async {
    String url = "$baseUrl/store/$storeId/absensi";

    var response = await ApiService.handleResponse(() async {
      await ApiService.postDataWithImage(
        url: url,
        fields: [
          {"status": "hadir"}
        ],
        files: [
          {"foto_path": image.path}
        ],
        errorMessage: "Failed to attend",
      );

      return true;
    });

    return response;
  }

  Future<ApiReturnValue<bool>> cashierAbsent(
      {required int storeId,
      required String status,
      required String name,
      required String reason,
      required String fromDate,
      required String toDate}) async {
    String url = "$baseUrl/store/$storeId/absensi";

    var response = await ApiService.handleResponse(() async {
      await ApiService.post(
        url: url,
        body: {
          'status': status,
          "nama_pemberi_izin": name,
          "alasan_izin": reason,
          "mulai_izin": fromDate,
          "selesai_izin": toDate,
        },
        errorMessage: "Failed to absent",
      );

      return true;
    });

    return response;
  }

  Future<ApiReturnValue<Absence>> getAbsence(
      {required int storeId, String? start, String? end}) async {
    start ??= DateFormat('yyyy-MM-dd').format(DateTime.now());
    end ??= DateFormat('yyyy-MM-dd').format(DateTime.now());

    String url =
        "$baseUrl/absensi/riwayat/$storeId?start_date=$start&end_date=$end";

    var response = await ApiService.handleResponse(() async {
      var result = await ApiService.get(
        url: url,
        errorMessage: "Failed to get absence",
      );

      Absence absence = Absence.fromJson(result);

      return absence;
    });

    return response;
  }
}

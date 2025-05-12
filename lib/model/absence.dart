part of 'model.dart';

class Absence extends Equatable {
  final int attend;
  final int permission;
  final int sick;
  final int absent;
  final List<Attend> attendList;
  final List<Absent> absentList;

  const Absence({
    required this.attend,
    required this.permission,
    required this.sick,
    required this.absent,
    required this.attendList,
    required this.absentList,
  });

  factory Absence.fromJson(Map<String, dynamic> json) => Absence(
    attend: json['rekap']['hadir'],
    permission: json['rekap']['izin'],
    sick: json['rekap']['sakit'],
    absent: json['rekap']['tidak_hadir'],
    attendList: json['data_absensi'] != null ? (json['data_absensi'] as Iterable).map((e) => Attend.fromJson(e)).toList() : [],
    absentList: json['tidak_hadir'] != null ? (json['tidak_hadir'] as Iterable).map((e) => Absent.fromJson(e)).toList() : [],
  );

  @override
  List<Object?> get props => [
    attend,
    permission,
    sick,
    absent,
    attendList,
    absentList,
  ];
}

class Attend extends Equatable {
  final int id;
  final int storeId;
  final int cashierId;
  final String name;
  final String status;
  final String? permittorName;
  final String? image;
  final String? reason;
  final String? fromDate;
  final String? toDate;

  const Attend({
    required this.id,
    required this.storeId,
    required this.cashierId,
    required this.name,
    required this.status,
    this.permittorName,
    this.image,
    this.reason,
    this.fromDate,
    this.toDate,
  });

  factory Attend.fromJson(Map<String, dynamic> json) => Attend(
        id: json['id'],
        storeId: json['store_id'],
        cashierId: json['kasir_id'],
        name: json['nama'],
        status: json['status'],
        permittorName: json['name_pemberi_izin'] ?? '',
        image: json['foto_path'] ?? '',
        reason: json['alasan_izin'] ?? '',
        fromDate: json['mulai_izin'] ?? '',
        toDate: json['selesai_izin'] ?? '',
      );

  @override
  List<Object?> get props => [
        id,
        storeId,
        cashierId,
        name,
        status,
        permittorName,
        image,
        reason,
        fromDate,
        toDate,
      ];
}

class Absent extends Equatable {
  final int id;

  const Absent({
    required this.id,
  });

  factory Absent.fromJson(Map<String, dynamic> json) => Absent(
        id: json['id'],
      );

  @override
  List<Object?> get props => [];
}

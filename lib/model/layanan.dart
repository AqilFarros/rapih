part of 'model.dart';

class Layanan extends Equatable {
  final int id;
  final String name;
  final int duration;
  final int storeId;

  const Layanan({
    required this.id,
    required this.name,
    required this.duration,
    required this.storeId,
  });

  factory Layanan.fromJson(Map<String, dynamic> json) => Layanan(
    id: json['id'] as int,
    name: json['name'] as String,
    duration: json['duration'] as int,
    storeId: json['store_id'] as int,
  );

  @override
  List<Object?> get props => [id, name, duration, storeId,];
}
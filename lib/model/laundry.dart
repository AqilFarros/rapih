part of 'model.dart';

class Laundry extends Equatable {
  final String name;
  final String address;
  final String? description;
  final String contactNumber;
  final String picture;
  final String logo;
  final String? qris;

  const Laundry({
    required this.name,
    required this.address,
    this.description,
    required this.contactNumber,
    required this.picture,
    required this.logo,
    this.qris,
  });

  // factory Laundry.fromJson(Map<String, dynamic> json) => Laundry();

  @override
  List<Object?> get props => [];
}

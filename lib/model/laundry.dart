part of 'model.dart';

class Laundry extends Equatable {
  final int id;
  final String name;
  final String address;
  final String? description;
  final String contactNumber;
  final String picture;
  final String logo;
  final String? qris;

  const Laundry({
    required this.id,
    required this.name,
    required this.address,
    this.description,
    required this.contactNumber,
    required this.picture,
    required this.logo,
    this.qris,
  });

  factory Laundry.fromJson(Map<String, dynamic> json) => Laundry(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        description: json["description"] != "" ? json["description"] : "",
        contactNumber: json["contact_number"],
        picture: json["picture"],
        logo: json["logo"],
        qris: json["qris"] != "" ? json["qris"] : null,
      );

  @override
  List<Object?> get props => [
        name,
        address,
        description,
        contactNumber,
        picture,
        logo,
        qris,
      ];
}

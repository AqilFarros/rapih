part of 'model.dart';

class Laundry extends Equatable {
  final int id;
  final String name;
  final String address;
  final String? description;
  final String contactNumber;
  final String picture;
  final String logo;
  // final String? qris;
  final Wallet? wallet;

  const Laundry({
    required this.id,
    required this.name,
    required this.address,
    this.description,
    required this.contactNumber,
    required this.picture,
    required this.logo,
    // this.qris,
    this.wallet,
  });

  factory Laundry.fromJson(Map<String, dynamic> json) => Laundry(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        description: json["description"] != "" ? json["description"] : "",
        contactNumber: json["contact_number"],
        picture: json["picture"],
        logo: json["logo"],
        // qris: json["qris"] != "" ? json["qris"] : null,
      );

  Laundry copyWith(
      {int? id,
      String? name,
      String? address,
      String? description,
      String? contactNumber,
      String? picture,
      String? logo,
      // String? qris,
      Wallet? wallet}) {
    return Laundry(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      contactNumber: contactNumber ?? this.contactNumber,
      picture: picture ?? this.picture,
      logo: logo ?? this.logo,
      // qris: qris ?? this.qris,
      wallet: wallet ?? this.wallet,
    );
  }

  @override
  List<Object?> get props => [
        name,
        address,
        description,
        contactNumber,
        picture,
        logo,
        // qris,
        wallet,
      ];
}

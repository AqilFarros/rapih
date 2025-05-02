part of 'model.dart';

class Customer extends Equatable {
  final int id;
  final String name;
  final String address;
  final String number;
  final int storeId;

  const Customer({
    required this.id,
    required this.name,
    required this.address,
    required this.number,
    required this.storeId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        number: json['number'],
        storeId: json['store_id'],
      );

  @override
  List<Object> get props => [
        id,
        name,
        address,
        number,
        storeId,
      ];
}

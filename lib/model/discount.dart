part of 'model.dart';

class Discount extends Equatable {
  final int id;
  final String name;
  final int amount;
  final int storeId;

  const Discount({
    required this.id,
    required this.name,
    required this.amount,
    required this.storeId,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json['id'] as int,
        name: json['name'] as String,
        amount: json['amount'] as int,
        storeId: json['store_id'] as int,
      );

  @override
  List<Object> get props => [
        id,
        name,
        amount,
        storeId,
      ];
}

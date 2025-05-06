part of 'model.dart';

class Parfume extends Equatable {
  final int id;
  final String name;
  final int price;
  final int storeId;

  const Parfume({
    required this.id,
    required this.name,
    required this.price,
    required this.storeId,
  });

  factory Parfume.fromJson(Map<String, dynamic> json) => Parfume(
    id: json['id'] as int,
    name: json['name'] as String,
    price: json['price'] as int,
    storeId: json['store_id'] as int,
  );

  @override
  List<Object> get props => [
        id,
        name,
        price,
        storeId,
      ];
}

part of 'model.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final double price;
  final int storeId;
  final int categoryId;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.storeId,
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as double,
      storeId: json['store_id'] as int,
      categoryId: json['category_id'] as int,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        storeId,
        categoryId,
      ];
}

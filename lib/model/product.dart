part of 'model.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int price;
  final int storeId;
  final int categoryId;
  final Category? category;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.storeId,
    required this.categoryId,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      storeId: json['store_id'] as int,
      categoryId: json['category_id'] as int,
    );
  }

  Product copyWith({Category? category}) {
    return Product(
      id: id,
      name: name,
      price: price,
      storeId: storeId,
      categoryId: categoryId,
      category: category ?? this.category,
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

part of 'model.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final int storeId;

  const Category({
    required this.id,
    required this.name,
    required this.storeId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      storeId: json['store_id'] as int,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        storeId,
      ];
}

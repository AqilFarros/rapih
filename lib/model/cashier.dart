part of 'model.dart';

class Cashier extends Equatable {
  final int id;
  final int userId;
  final String? name;
  final int storeId;
  final bool isActive;

  const Cashier({
    required this.id,
    required this.userId,
    this.name,
    required this.storeId,
    required this.isActive,
  });

  factory Cashier.fromJson(Map<String, dynamic> json) {
    return Cashier(
      id: json['id'],
      userId: json['user_id'],
      name: json['user']['name'] ?? '',
      storeId: json['store_id'],
      isActive: json['is_active'] == 1
          ? true
          : json['is_active'] == true
              ? true
              : false,
    );
  }

  @override
  List<Object> get props => [
        id,
        userId,
        name ?? '',
        storeId,
        isActive,
      ];
}

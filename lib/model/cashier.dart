part of 'model.dart';

class Cashier extends Equatable {
  final int id;
  final int userId;
  final int storeId;
  final bool isActive;

  const Cashier({
    required this.id,
    required this.userId,
    required this.storeId,
    required this.isActive,
  });

  factory Cashier.fromJson(Map<String, dynamic> json) {
    return Cashier(
      id: json['id'],
      userId: json['user_id'],
      storeId: json['store_id'],
      isActive: json['is_active'] == 1 ? true : false,
    );
  }

  @override
  List<Object> get props => [
        id,
        userId,
        storeId,
        isActive,
      ];
}

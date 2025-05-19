part of 'model.dart';

class Wallet extends Equatable {
  final int id;
  final int balance;
  final int storeId;
  final double income;
  final double expense;

  const Wallet({
    required this.id,
    required this.balance,
    required this.storeId,
    required this.income,
    required this.expense,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json['wallet']['id'],
        balance: json['wallet']['balance'],
        storeId: json['wallet']['store_id'],
        income: double.parse(json['totalIncome'].toString()),
        expense: double.parse(json['totalExpense'].toString()),
      );

  @override
  List<Object> get props => [
        id,
        balance,
        storeId,
        income,
        expense,
      ];
}

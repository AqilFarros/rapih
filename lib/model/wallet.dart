part of 'model.dart';

class Wallet extends Equatable {
  final int id;
  final int balance;
  final int storeId;
  final int income;
  final int expense;

  const Wallet(
      {required this.id, required this.balance, required this.storeId, required this.income, required this.expense,});

  factory Wallet.fromJson(Map<String, dynamic> data,Map<String, dynamic> json) => Wallet(
        id: json['id'],
        balance: json['balance'],
        storeId: json['store_id'],
        income: data['totalIncome'] ,
        expense: data['totalExpense'],
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

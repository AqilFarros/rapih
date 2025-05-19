part of 'model.dart';

class Order extends Equatable {
  final int id;
  final int orderCode;
  final int storeId;
  final String status;
  final Customer customer;
  final Layanan layanan;
  final Product product;
  final double productQuantity;
  final int subTotal;
  final int totalPrice;
  final Discount? discount;
  final Parfume? parfume;
  final Delivery? delivery;
  final String paymentMethod;
  final bool isPaid;
  final String estDate;

  const Order({
    required this.id,
    required this.orderCode,
    required this.storeId,
    required this.status,
    required this.customer,
    required this.layanan,
    required this.product,
    required this.productQuantity,
    required this.subTotal,
    required this.totalPrice,
    this.discount,
    this.parfume,
    this.delivery,
    required this.paymentMethod,
    required this.isPaid,
    required this.estDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        orderCode: json['kode_pesanan'],
        storeId: json['store_id'],
        status: json['status'],
        customer: Customer.fromJson(json['customer']),
        layanan: Layanan.fromJson(json['layanans']),
        product: Product.fromJson(json['products']),
        productQuantity: json['products']['pivot']['quantity'],
        subTotal: json['products']['pivot']['subtotal'],
        totalPrice: json['total_price'],
        discount: json['discount'] != null ? Discount.fromJson(json['discount']) : null,
        parfume: json['parfume'] != null ? Parfume.fromJson(json['parfume']) : null,
        delivery: json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null,
        paymentMethod: json['payment_method'],
        isPaid: json['is_paid'] == 1 ? true : false,
        estDate: json['estimation_date'],
      );

  // Order copyWith({
  //   int? id,
  //   int? storeId,
  //   String? status,
  //   Customer? customer,
  //   Layanan? layanan,
  //   Product? product,
  //   double? productQuantity,
  //   int? subTotal,
  //   Discount? discount,
  //   Parfume? parfume,
  //   Delivery? delivery,
  //   String? paymentMethod,
  //   bool? isPaid,
  //   String? estDate,
  // }) {
  //   return Order(
  //     id: id ?? this.id,
  //     storeId: storeId ?? this.storeId,
  //     status: status ?? this.status,
  //     customer: customer ?? this.customer,
  //     layanan: layanan ?? this.layanan,
  //     product: product ?? this.product,
  //     productQuantity: productQuantity ?? this.productQuantity,
  //     subTotal: subTotal ?? this.subTotal,
  //     discount: discount ?? this.discount,
  //     parfume: parfume ?? this.parfume,
  //     delivery: delivery ?? this.delivery,
  //     paymentMethod: paymentMethod ?? this.paymentMethod,
  //     isPaid: isPaid ?? this.isPaid,
  //     estDate: estDate ?? this.estDate,
  //   );
  // }

  @override
  List<Object?> get props => [
        id,
        orderCode,
        storeId,
        status,
        customer,
        layanan,
        product,
        productQuantity,
        subTotal,
        totalPrice,
        discount,
        parfume,
        delivery,
        paymentMethod,
        isPaid,
        estDate,
      ];
}

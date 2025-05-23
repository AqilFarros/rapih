part of 'model.dart';

class Order extends Equatable {
  final int id;
  final String orderCode;
  final int storeId;
  final String status;
  final String cashierName;
  final Customer customer;
  final Layanan? layanan;
  final List<ProductOrder>? products;
  final double totalPrice;
  final Discount? discount;
  final Parfume? parfume;
  final Delivery? delivery;
  final String paymentMethod;
  final bool isPaid;
  final String estDate;
  final String createdAt;

  const Order({
    required this.id,
    required this.orderCode,
    required this.storeId,
    required this.status,
    required this.cashierName,
    required this.customer,
    this.layanan,
    this.products,
    required this.totalPrice,
    this.discount,
    this.parfume,
    this.delivery,
    required this.paymentMethod,
    required this.isPaid,
    required this.estDate,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        orderCode: json['kode_pesanan'],
        storeId: json['store_id'],
        status: json['status'],
        cashierName: json['kasir_id'],
        customer: Customer.fromJson(json['customer']),
        layanan: json['layanans'] != null
            ? Layanan.fromJson(json['layanans'])
            : null,
        products: json['products'] != null
            ? (json['products'] as Iterable)
                .map((item) => ProductOrder.fromJson(item))
                .toList()
            : null,
        totalPrice: double.parse(json['total_price'].toString()),
        discount: json['discount'] != null
            ? Discount.fromJson(json['discount'])
            : null,
        parfume:
            json['parfume'] != null ? Parfume.fromJson(json['parfume']) : null,
        delivery: json['delivery'] != null
            ? Delivery.fromJson(json['delivery'])
            : null,
        paymentMethod: json['payment_method'],
        isPaid: json['is_paid'] == 1 ? true : false,
        estDate: json['estimation_date'],
        createdAt: json['created_at'],
      );

  Order copyWith({
    int? id,
    String? orderCode,
    int? storeId,
    String? status,
    String? cashierName,
    Customer? customer,
    Layanan? layanan,
    List<ProductOrder>? products,
    double? totalPrice,
    Discount? discount,
    Parfume? parfume,
    Delivery? delivery,
    String? paymentMethod,
    bool? isPaid,
    String? estDate,
    String? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      orderCode: orderCode ?? this.orderCode,
      storeId: storeId ?? this.storeId,
      status: status ?? this.status,
      cashierName: cashierName ?? this.cashierName,
      customer: customer ?? this.customer,
      layanan: layanan ?? this.layanan,
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      discount: discount ?? this.discount,
      parfume: parfume ?? this.parfume,
      delivery: delivery ?? this.delivery,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      estDate: estDate ?? this.estDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderCode,
        storeId,
        status,
        cashierName,
        customer,
        layanan,
        products,
        totalPrice,
        discount,
        parfume,
        delivery,
        paymentMethod,
        isPaid,
        estDate,
        createdAt,
      ];
}

class ProductOrder {
  final Product product;
  final double quantity;
  final double subTotal;

  const ProductOrder({
    required this.product,
    required this.quantity,
    required this.subTotal,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) => ProductOrder(
        product: Product.fromJson(json),
        quantity: double.parse(json['pivot']['quantity'].toString()),
        subTotal: double.parse(json['pivot']['subtotal'].toString()),
      );
}

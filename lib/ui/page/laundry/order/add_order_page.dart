part of '../../page.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({
    super.key,
    required this.laundry,
  });

  final Laundry laundry;

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final TextEditingController customerController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController layananController = TextEditingController();
  final TextEditingController parfumeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  final TextEditingController receiveMoneyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Customer? selectedCustomer;
  Layanan? selectedLayanan;
  Parfume? selectedParfume;
  Discount? selectedDiscount;
  Delivery? selectedDelivery;
  List<SelectedProduct> selectedProduct = [];
  String? selectedPayment;
  String? selectedPaymentStatus;
  List<String> payments = ['Cash', 'Transfer', 'E-Wallet'];
  List<String> paymentStatus = ['Sudah Dibayar', 'Belum Dibayar'];

  @override
  void initState() {
    selectedPayment = payments.first;
    selectedPaymentStatus = paymentStatus.first;
    receiveMoneyController.text = 0.toString();
    super.initState();
  }

  double uangKembalian() {
    double receivedMoney = double.tryParse(receiveMoneyController.text) ?? 0;

    double total = calculateTotalPrice(selectedProduct).toDouble() +
        (selectedDelivery?.amount ?? 0) +
        (selectedParfume?.price ?? 0) -
        (selectedDiscount?.amount ?? 0);

    double change = receivedMoney - total;

    return change;
  }

  void selectProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(
          laundry: widget.laundry,
          isOrder: true,
        ),
      ),
    );

    if (result != null && result is Product) {
      double? quantity;

      await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController quantityController =
              TextEditingController();

          return AlertDialog(
            title: Text(
              "Jumlah Produk?",
              style: medium.copyWith(fontSize: heading2),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                  label: "Quantity",
                  controller: quantityController,
                  hintText: "Quantity",
                  validator: (value) {
                    return numberValidator(value, "Quantity");
                  },
                ),
              ],
            ),
            actions: [
              SecondaryButton(
                name: "Cancel",
                function: () {
                  Navigator.pop(context);
                },
              ),
              PrimaryButton(
                name: "Ok",
                function: () {
                  final text = quantityController.text.trim();
                  if (text.isNotEmpty) {
                    final doubleValue = double.tryParse(text);
                    if (doubleValue != null && doubleValue > 0) {
                      quantity = doubleValue;
                    }
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );

      if (quantity != null && quantity! > 0) {
        setState(() {
          selectedProduct
              .add(SelectedProduct(product: result, quantity: quantity!));
        });
      }

      // setState(() {
      //   productController.text = selectedProduct.isNotEmpty ? "" : "";
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Order',
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: defaultMargin),
                AddOrderWidget(
                  page: CustomerPage(
                    laundry: widget.laundry,
                    isOrder: true,
                  ),
                  resultFunction: (Customer result) {
                    setState(() {
                      selectedCustomer = result;
                      customerController.text = result.name;
                    });
                  },
                  controller: customerController,
                  name: 'Customer',
                  icon: Icons.person,
                  isRequired: true,
                ),
                const SizedBox(height: defaultMargin),
                CardWidget(
                  content: selectedProduct.isEmpty
                      ? InputField(
                          onTap: () async {
                            selectProduct();
                          },
                          label: 'Product',
                          controller: productController,
                          hintText: "Please add a product",
                          icon: Icons.production_quantity_limits_rounded,
                          validator: (value) {
                            return requiredValidator(value, 'Product');
                          },
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product",
                                  style: medium,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    selectProduct();
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.all(defaultMargin / 4),
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(
                                        defaultMargin / 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: defaultMargin / 2,
                            ),
                            ...selectedProduct.map(
                              (item) => Container(
                                padding: const EdgeInsets.only(
                                    bottom: defaultMargin / 2),
                                margin: const EdgeInsets.only(
                                    bottom: defaultMargin / 2),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: whiteSmokeColor),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.product.name} (${item.quantity})",
                                          style: medium.copyWith(
                                            color: mainColor,
                                            fontSize: heading2,
                                          ),
                                        ),
                                        Text(
                                          "${NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0,
                                          ).format(item.product.price)} (${item.product.categoryName})",
                                          style: light.copyWith(
                                            fontSize: heading3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(
                                          item.product.price * item.quantity),
                                      style: medium.copyWith(
                                        color: mainColor,
                                        fontSize: heading2,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedProduct.remove(item);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red[400],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: defaultMargin / 2,
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: defaultMargin),
                AddOrderWidget(
                  page: LayananPage(
                    laundry: widget.laundry,
                    isOrder: true,
                  ),
                  resultFunction: (Layanan result) {
                    setState(() {
                      selectedLayanan = result;
                      layananController.text =
                          "${result.name} (${result.duration} jam)";
                    });
                  },
                  controller: layananController,
                  name: 'Layanan',
                  icon: Icons.local_laundry_service_outlined,
                  isRequired: true,
                ),
                const SizedBox(height: defaultMargin),
                AddOrderWidget(
                  page: ParfumePage(
                    laundry: widget.laundry,
                    isOrder: true,
                  ),
                  resultFunction: (Parfume result) {
                    setState(() {
                      selectedParfume = result;
                      parfumeController.text =
                          "${result.name} (${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(result.price)})";
                    });
                  },
                  controller: parfumeController,
                  name: 'Parfume',
                  icon: Icons.local_laundry_service_outlined,
                ),
                const SizedBox(height: defaultMargin),
                AddOrderWidget(
                  page: DeliveryPage(
                    laundry: widget.laundry,
                    isOrder: true,
                  ),
                  resultFunction: (Delivery result) {
                    setState(() {
                      selectedDelivery = result;
                      deliveryController.text =
                          "${result.name} (${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(result.amount)})";
                    });
                  },
                  controller: deliveryController,
                  name: 'Delivery',
                  icon: Icons.delivery_dining_rounded,
                ),
                const SizedBox(height: defaultMargin),
                AddOrderWidget(
                  page: DiscountPage(
                    laundry: widget.laundry,
                    isOrder: true,
                  ),
                  resultFunction: (Discount result) {
                    setState(() {
                      selectedDiscount = result;
                      discountController.text =
                          "${result.name} (${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(result.amount)})";
                    });
                  },
                  icon: Icons.discount_rounded,
                  name: "Discount",
                  controller: discountController,
                ),
                const SizedBox(height: defaultMargin),
                CardWidget(
                  content: DropdownWidget(
                    label: "Payment method",
                    selectedValue: selectedPayment,
                    items: payments,
                    getLabel: (item) => item,
                    getValue: (item) => item,
                    onChanged: (item) {
                      setState(() {
                        selectedPayment = item;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Please select a payment" : null,
                    icon: Icons.payment_rounded,
                  ),
                ),
                const SizedBox(height: defaultMargin),
                CardWidget(
                  content: DropdownWidget(
                    label: "Payment status",
                    selectedValue: selectedPaymentStatus,
                    items: paymentStatus,
                    getLabel: (item) => item,
                    getValue: (item) => item,
                    onChanged: (item) {
                      setState(() {
                        selectedPaymentStatus = item;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Please select a payment status" : null,
                    icon: Icons.payment_rounded,
                  ),
                ),
                const SizedBox(height: defaultMargin),
                CardWidget(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        label: "Uang diterima",
                        controller: receiveMoneyController,
                        hintText: "0",
                        validator: (value) {},
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: defaultMargin / 2,
                      ),
                      Text(
                        "Kembalian: ${NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(
                          uangKembalian() < 0 ? 0 : uangKembalian(),
                        )}",
                        style: medium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultMargin),
                const Divider(),
                const SizedBox(height: defaultMargin),
                CardWidget(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Subtotal produk",
                            style: medium.copyWith(fontSize: heading3),
                          ),
                          const Spacer(),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(calculateTotalPrice(selectedProduct)),
                            style: medium.copyWith(fontSize: heading3),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Biaya delivery",
                            style: medium.copyWith(fontSize: heading3),
                          ),
                          const Spacer(),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(
                              selectedDelivery?.amount ?? 0,
                            ),
                            style: medium.copyWith(fontSize: heading3),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Biaya parfum",
                            style: medium.copyWith(fontSize: heading3),
                          ),
                          const Spacer(),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(
                              selectedParfume?.price ?? 0,
                            ),
                            style: medium.copyWith(fontSize: heading3),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Diskon",
                            style: medium.copyWith(fontSize: heading3),
                          ),
                          const Spacer(),
                          Text(
                            "-${NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(
                              selectedDiscount?.amount ?? 0,
                            )}",
                            style: medium.copyWith(fontSize: heading3),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            "Total",
                            style: semiBold.copyWith(fontSize: heading1),
                          ),
                          const Spacer(),
                          Text(
                            NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 0,
                            ).format(
                              calculateTotalPrice(selectedProduct) +
                                  (selectedDelivery?.amount ?? 0) +
                                  (selectedParfume?.price ?? 0) -
                                  (selectedDiscount?.amount ?? 0),
                            ),
                            style: semiBold.copyWith(
                              color: mainColor,
                              fontSize: heading1,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Est selesai: ",
                        style: semiBold.copyWith(fontSize: heading3),
                      ),
                      Text(
                        formatWaktuDenganPenambahan(
                            tambahJam: selectedLayanan?.duration ?? 0),
                        style: semiBold.copyWith(
                          fontSize: heading3,
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultMargin),
                BlocConsumer<OrderCubit, OrderState>(
                  listener: (context, state) {
                    if (state is OrderLoaded) {
                      Navigator.pop(context);
                    } else {}
                  },
                  builder: (context, state) {
                    return isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircularProgressIndicator(color: mainColor),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SecondaryButton(
                                name: "Cancel",
                                function: () {
                                  if (!isLoading) {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                              const SizedBox(width: defaultMargin / 2),
                              PrimaryButton(
                                name: "Save",
                                function: () async {
                                  if (!isLoading &&
                                      formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await context
                                        .read<OrderCubit>()
                                        .createOrder(
                                          storeId: widget.laundry.id,
                                          customerId: selectedCustomer!.id,
                                          layananId: selectedLayanan!.id,
                                          products: selectedProduct,
                                          paymentMethod: selectedPayment!,
                                          isPaid: selectedPaymentStatus ==
                                                  "Sudah Dibayar"
                                              ? true
                                              : false,
                                        );
                                  }
                                },
                              ),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddOrderWidget<T> extends StatelessWidget {
  const AddOrderWidget({
    super.key,
    required this.page,
    required this.resultFunction,
    required this.controller,
    required this.name,
    required this.icon,
    this.isRequired = false,
  });

  final Widget page;
  final Function resultFunction;
  final TextEditingController controller;
  final String name;
  final IconData icon;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      content: InputField(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );

          if (result != null && result is T) {
            resultFunction(result);
          }
        },
        label: name,
        controller: controller,
        hintText: "Please add a $name",
        icon: icon,
        validator: (value) {
          if (isRequired == true) {
            return requiredValidator(value, name);
          }
          return null;
        },
      ),
    );
  }
}

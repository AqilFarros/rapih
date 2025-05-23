part of '../../page.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    super.key,
    required this.laundry,
    required this.order,
  });

  final Laundry laundry;
  final Order order;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<Map<String, dynamic>> status = [
    {
      "label": "Pending",
      "value": "pending",
    },
    {
      "label": "Dicuci",
      "value": "dicuci",
    },
    {
      "label": "Bisa diambil",
      "value": "bisa_diambil",
    },
    {
      "label": "Expired",
      "value": "expired",
    },
    {
      "label": "Telat",
      "value": "telat",
    },
  ];
  String? selectedStatus;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initPrinter();
    selectedStatus = widget.order.status;
    if (widget.order.products == null) {
      context
          .read<OrderCubit>()
          .getOrderById(storeId: widget.laundry.id, orderId: widget.order.id);
    }
  }

  final BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<BluetoothDevice> devices = [];

  void initPrinter() async {
    bool isConnected = await printer.isConnected ?? false;
    if (!isConnected) {
      devices = await printer.getBondedDevices();
      // pilih salah satu device secara manual atau otomatis
      if (devices.isNotEmpty) {
        await printer.connect(devices[0]); // konek ke perangkat pertama
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Order',
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoaded) {
              Order selectedOrder = state.orders
                  .where((item) => item.id == widget.order.id)
                  .first;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    CardWidget(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Kode pesanan: ",
                                style: medium.copyWith(fontSize: heading2),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(defaultMargin / 2),
                                  color: switch (selectedOrder.status) {
                                    "expired" => redColor,
                                    "pending" => Colors.amber,
                                    "bisa_diambil" => greenColor,
                                    "dicuci" => secondaryColor,
                                    "completed" => mainColor,
                                    _ => grayColor,
                                  },
                                ),
                                child: Text(
                                  selectedOrder.status == 'bisa_diambil'
                                      ? "Bisa diambil"
                                      : selectedOrder.status,
                                  style: medium.copyWith(
                                    fontSize: heading3,
                                    color: selectedOrder.status == "telat"
                                        ? blackColor
                                        : whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            selectedOrder.orderCode,
                            style: semiBold.copyWith(
                              fontSize: heading1,
                              color: mainColor,
                            ),
                          ),
                          const SizedBox(height: defaultMargin),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: heading1,
                                color: mainColor,
                              ),
                              Text(
                                " ${selectedOrder.customer.name}",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                  color: grayColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultMargin / 2),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: heading1,
                                color: mainColor,
                              ),
                              Text(
                                " ${selectedOrder.customer.address}",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                  color: grayColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultMargin / 2),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: heading1,
                                color: mainColor,
                              ),
                              Text(
                                " ${selectedOrder.customer.number}",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                  color: grayColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultMargin),
                          Row(
                            children: [
                              Text(
                                "Nama kasir: ",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                ),
                              ),
                              Text(
                                selectedOrder.cashierName,
                                style: medium.copyWith(
                                  fontSize: heading2,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultMargin / 2),
                          Row(
                            children: [
                              Text(
                                "Metode pembayaran: ",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                ),
                              ),
                              Text(
                                selectedOrder.paymentMethod,
                                style: medium.copyWith(
                                  fontSize: heading2,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultMargin / 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Status pembayaran: ",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  selectedOrder.isPaid
                                      ? "sudah dibayar"
                                      : "belum dibayar",
                                  style: medium.copyWith(
                                    fontSize: heading2,
                                    color: selectedOrder.isPaid
                                        ? greenColor
                                        : redColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultMargin / 2),
                          Text(
                            "Tanggal kirim:",
                            style: medium.copyWith(
                              fontSize: heading2,
                            ),
                          ),
                          Text(
                            DateFormat("EEEE, dd MMMM yyyy HH:mm", 'id_ID')
                                .format(
                              DateTime.parse(selectedOrder.createdAt),
                            ),
                            style: medium.copyWith(
                              fontSize: heading2,
                              color: mainColor,
                            ),
                          ),
                          const SizedBox(height: defaultMargin / 2),
                          Text(
                            "Estismasi selesai:",
                            style: medium.copyWith(
                              fontSize: heading2,
                            ),
                          ),
                          Text(
                            DateFormat("EEEE, dd MMMM yyyy HH:mm", 'id_ID')
                                .format(
                              DateTime.parse(selectedOrder.estDate),
                            ),
                            style: medium.copyWith(
                              fontSize: heading2,
                              color: mainColor,
                            ),
                          ),
                          const SizedBox(height: defaultMargin),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              isLoading
                                  ? CircularProgressIndicator(
                                      color: mainColor,
                                    )
                                  : SecondaryButton(
                                      name: "Ganti status",
                                      function: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(
                                              "Ganti status",
                                              style: medium.copyWith(
                                                  fontSize: heading2),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                DropdownWidget(
                                                  label: "Status",
                                                  selectedValue: selectedStatus,
                                                  items: status,
                                                  getLabel: (item) =>
                                                      item['label'],
                                                  getValue: (item) =>
                                                      item['value'],
                                                  onChanged: (item) {
                                                    setState(() {
                                                      selectedStatus = item;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return "";
                                                  },
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              SecondaryButton(
                                                name: "Cancel",
                                                function: () =>
                                                    Navigator.pop(context),
                                              ),
                                              PrimaryButton(
                                                name: "Save",
                                                function: () async {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    isLoading = true;
                                                  });

                                                  await context
                                                      .read<OrderCubit>()
                                                      .updateStatus(
                                                        storeId:
                                                            widget.laundry.id,
                                                        orderId:
                                                            selectedOrder.id,
                                                        status: selectedStatus!,
                                                      );

                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultMargin),
                    CardWidget(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Product",
                              style: medium.copyWith(fontSize: heading2)),
                          const SizedBox(height: defaultMargin),
                          Table(
                            border: TableBorder.all(color: whiteSmokeColor),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "Nama produk",
                                      style: medium.copyWith(
                                        fontSize: heading3,
                                        color: grayColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "Harga satuan",
                                      style: medium.copyWith(
                                        fontSize: heading3,
                                        color: grayColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "Qty",
                                      style: medium.copyWith(
                                        fontSize: heading3,
                                        color: grayColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Text(
                                      "Subtotal",
                                      style: medium.copyWith(
                                        fontSize: heading3,
                                        color: grayColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              ...selectedOrder.products!.map(
                                (item) => TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          item.product.name,
                                          style: medium.copyWith(
                                              fontSize: heading3),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          NumberFormat.currency(
                                            locale: 'id_ID',
                                            symbol: 'Rp. ',
                                            decimalDigits: 0,
                                          ).format(item.product.price),
                                          style: medium.copyWith(
                                              fontSize: heading3),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          item.quantity.toString(),
                                          style: medium.copyWith(
                                              fontSize: heading3),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          NumberFormat.currency(
                                            locale: 'id_ID',
                                            symbol: 'Rp. ',
                                            decimalDigits: 0,
                                          ).format(item.subTotal),
                                          style: medium.copyWith(
                                              fontSize: heading3),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultMargin),
                    Row(
                      children: [
                        Expanded(
                          child: CardWidget(
                            content: Column(
                              children: [
                                Text(
                                  "Layanan",
                                  style: medium.copyWith(fontSize: heading2),
                                ),
                                Text(
                                  selectedOrder.layanan!.name,
                                  style: medium.copyWith(
                                      fontSize: heading2, color: mainColor),
                                ),
                                Text(
                                  "Durasi: ${selectedOrder.layanan!.duration} jam",
                                  style: regular.copyWith(
                                    fontSize: heading2,
                                    color: grayColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: defaultMargin),
                        Expanded(
                          child: CardWidget(
                            content: Column(
                              children: [
                                Text(
                                  "Parfume",
                                  style: medium.copyWith(fontSize: heading2),
                                ),
                                Text(
                                  selectedOrder.parfume != null
                                      ? selectedOrder.parfume!.name
                                      : "Tidak ada",
                                  style: medium.copyWith(
                                      fontSize: heading2, color: mainColor),
                                ),
                                Text(
                                  selectedOrder.parfume != null
                                      ? NumberFormat.currency(
                                          locale: 'id_ID',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0,
                                        ).format(selectedOrder.parfume!.price)
                                      : "Rp. 0",
                                  style: regular.copyWith(
                                    fontSize: heading2,
                                    color: grayColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultMargin),
                    Row(
                      children: [
                        Expanded(
                          child: CardWidget(
                            content: Column(
                              children: [
                                Text(
                                  "Delivery",
                                  style: medium.copyWith(fontSize: heading2),
                                ),
                                Text(
                                  selectedOrder.delivery != null
                                      ? selectedOrder.delivery!.name
                                      : "Tidak ada",
                                  style: medium.copyWith(
                                      fontSize: heading2, color: mainColor),
                                ),
                                Text(
                                  selectedOrder.delivery != null
                                      ? NumberFormat.currency(
                                          locale: 'id_ID',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0,
                                        ).format(selectedOrder.delivery!.amount)
                                      : "Rp. 0",
                                  style: regular.copyWith(
                                    fontSize: heading2,
                                    color: grayColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: defaultMargin),
                        Expanded(
                          child: CardWidget(
                            content: Column(
                              children: [
                                Text(
                                  "Discount",
                                  style: medium.copyWith(fontSize: heading2),
                                ),
                                Text(
                                  selectedOrder.discount != null
                                      ? selectedOrder.discount!.name
                                      : "Tidak ada",
                                  style: medium.copyWith(
                                      fontSize: heading2, color: mainColor),
                                ),
                                Text(
                                  selectedOrder.discount != null
                                      ? NumberFormat.currency(
                                          locale: 'id_ID',
                                          symbol: '-Rp. ',
                                          decimalDigits: 0,
                                        ).format(selectedOrder.discount!.amount)
                                      : "-Rp. 0",
                                  style: regular.copyWith(
                                    fontSize: heading2,
                                    color: grayColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultMargin),
                    CardWidget(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ringkasan pembayaran",
                            style: medium.copyWith(fontSize: heading2),
                          ),
                          Row(
                            children: [
                              Text(
                                "Subtotal produk",
                                style: regular.copyWith(
                                  fontSize: heading3,
                                  color: grayColor,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp ',
                                  decimalDigits: 0,
                                ).format(
                                  selectedOrder.products!.fold(
                                      0.0, (sum, item) => sum + item.subTotal),
                                ),
                                style: medium.copyWith(fontSize: heading3),
                              ),
                            ],
                          ),
                          selectedOrder.parfume != null
                              ? Row(
                                  children: [
                                    Text(
                                      "Parfume",
                                      style: regular.copyWith(
                                        fontSize: heading3,
                                        color: grayColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(selectedOrder.parfume!.price),
                                      style:
                                          medium.copyWith(fontSize: heading3),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          selectedOrder.delivery != null
                              ? Row(
                                  children: [
                                    Text(
                                      "Delivery",
                                      style: regular.copyWith(
                                        fontSize: heading3,
                                        color: grayColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(selectedOrder.delivery!.amount),
                                      style:
                                          medium.copyWith(fontSize: heading3),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          selectedOrder.discount != null
                              ? Row(
                                  children: [
                                    Text(
                                      "Discount",
                                      style: regular.copyWith(
                                        fontSize: heading3,
                                        color: grayColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "-${NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(selectedOrder.discount!.amount)}",
                                      style:
                                          medium.copyWith(fontSize: heading3),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(height: defaultMargin),
                          const Divider(),
                          const SizedBox(height: defaultMargin),
                          Row(
                            children: [
                              Text(
                                "Total",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp ',
                                  decimalDigits: 0,
                                ).format(
                                  selectedOrder.products!.fold(
                                        0.0,
                                        (sum, item) => sum + item.subTotal,
                                      ) +
                                      (selectedOrder.parfume != null
                                          ? selectedOrder.parfume!.price
                                          : 0.0) +
                                      (selectedOrder.delivery != null
                                          ? selectedOrder.delivery!.amount
                                          : 0.0) -
                                      (selectedOrder.discount != null
                                          ? selectedOrder.discount!.amount
                                          : 0.0),
                                ),
                                style: medium.copyWith(
                                    fontSize: heading2, color: mainColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: defaultMargin / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final isConnected =
                                      await printer.isConnected ?? false;

                                  if (!isConnected) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Printer belum terhubung")),
                                    );
                                    return;
                                  }

                                  final invoiceText = await generateInvoiceText(
                                    title: "Nota Transaksi",
                                    order:
                                        selectedOrder, // pastikan `order` sudah tersedia
                                  );

                                  final lines = invoiceText.split('\n');

                                  for (var line in lines) {
                                    if (line.trim().isEmpty) {
                                      printer.printNewLine();
                                    } else {
                                      printer.printCustom(line, 1,
                                          0); // ukuran normal, rata kiri
                                    }
                                  }

                                  printer.printNewLine();
                                  printer.printNewLine();
                                  printer.paperCut(); // jika printer support
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: defaultMargin,
                                    vertical: defaultMargin / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        defaultMargin / 2),
                                    border: Border.all(color: whiteSmokeColor),
                                    color: whiteColor,
                                  ),
                                  child: Icon(
                                    Icons.print,
                                    color: blackColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: defaultMargin / 2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  sendOrderDetailsViaWhatsapp(
                                      customer: selectedOrder.customer,
                                      order: selectedOrder);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: defaultMargin,
                                    vertical: defaultMargin / 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        defaultMargin / 2),
                                    border: Border.all(color: greenColor),
                                    color: greenColor,
                                  ),
                                  child: Icon(
                                    Icons.chat,
                                    color: whiteColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: defaultMargin),
                    selectedOrder.status == "bisa_diambil"
                        ? SizedBox(
                            width: double.infinity,
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: mainColor,
                                    ),
                                  )
                                : PrimaryButton(
                                    name: "Tandai selesai",
                                    function: () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      await context
                                          .read<OrderCubit>()
                                          .completedOrder(
                                            storeId: widget.laundry.id,
                                            orderId: selectedOrder.id,
                                          );

                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                  ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: defaultMargin),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

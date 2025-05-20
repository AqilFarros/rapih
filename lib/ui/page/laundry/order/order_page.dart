part of '../../page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Map<String, dynamic>> status = [
    {
      "label": "Semua",
      "value": "all",
    },
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
      "label": "Completed",
      "value": "completed",
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
  List<Map<String, dynamic>> range = [
    {
      "label": "Semua",
      "value": "all",
    },
    {
      "label": "Hari ini",
      "value": "daily",
    },
    {
      "label": "7 hari",
      "value": "weekly",
    },
    {
      "label": "1 bulan",
      "value": "monthly",
    },
  ];
  String? selectedStatus;
  String? selectedRange;

  @override
  void initState() {
    selectedStatus = status[0]['value'];
    selectedRange = range[2]['value'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Current Order',
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          children: [
            CardWidget(
              content: Row(
                children: [
                  Expanded(
                    child: DropdownWidget(
                      label: "Status",
                      selectedValue: selectedStatus,
                      items: status,
                      getLabel: (value) => value['label'],
                      getValue: (value) => value['value'],
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                      },
                      validator: (value) {
                        return "";
                      },
                    ),
                  ),
                  const SizedBox(
                    width: defaultMargin / 2,
                  ),
                  Expanded(
                    child: DropdownWidget(
                      label: "Range",
                      selectedValue: selectedRange,
                      items: range,
                      getLabel: (value) => value['label'],
                      getValue: (value) => value['value'],
                      onChanged: (value) {
                        setState(() {
                          selectedRange = value;
                        });
                        context.read<OrderCubit>().getOrder(
                              storeId: widget.laundry.id,
                              range: selectedRange,
                            );
                      },
                      validator: (value) {
                        return "";
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is OrderLoaded) {
                  if (state.orders.isEmpty) {
                    return const SizedBox();
                  } else {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Total pesanan:",
                              style: medium.copyWith(fontSize: heading2),
                            ),
                            Text(
                              " ${selectedStatus != "all" ? state.orders.where((e) => e.status == selectedStatus).length : state.orders.length}",
                              style: semiBold.copyWith(
                                fontSize: heading2,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: defaultMargin,
                        ),
                        ...(selectedStatus != "all"
                            ? state.orders
                                .where((e) => e.status == selectedStatus)
                                .map((e) => [
                                      TransactionWidget(
                                          laundry: widget.laundry, order: e),
                                      const SizedBox(height: defaultMargin),
                                    ])
                                .expand((pair) => pair)
                            : state.orders
                                .map((e) => [
                                      TransactionWidget(
                                          laundry: widget.laundry, order: e),
                                      const SizedBox(height: defaultMargin),
                                    ])
                                .expand((pair) => pair))
                      ],
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

part of '../page.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<OrderCubit>();
    if (cubit.state is! OrderLoaded) {
      cubit.getOrder(storeId: widget.laundry.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          if (state.orders.isEmpty) {
            return const Center();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPage(laundry: widget.laundry),
                    ),
                  );
                },
                child: CardWidget(
                  content: Row(
                    children: [
                      Text(
                        "Manage order",
                        style: regular.copyWith(fontSize: heading2),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.search_rounded,
                        size: heading1,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              CardWidget(
                content: Row(
                  children: [
                    Image.asset("asset/image/list.png", height: 70),
                    const SizedBox(
                      width: defaultMargin,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.orders.where((item) => item.status == "pending" || item.status == "dicuci" || item.status == "telat").length} pesanan belum selesai!",
                            style: medium.copyWith(fontSize: heading2),
                          ),
                          const SizedBox(
                            height: defaultMargin / 2,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderPage(laundry: widget.laundry),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin,
                                vertical: defaultMargin / 3,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Selesaikan Sekarang",
                              style: semiBold.copyWith(
                                fontSize: heading4,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              Row(
                children: [
                  Expanded(
                    child: CardWidget(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Pending",
                            style: medium.copyWith(
                              fontSize: heading2,
                              color: mainColor,
                            ),
                          ),
                          Text(
                            state.orders
                                .where((item) => item.status == "pending")
                                .length
                                .toString(),
                            style: medium.copyWith(
                              fontSize: heading,
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: defaultMargin,
                  ),
                  Expanded(
                    child: CardWidget(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Terlambat",
                            style: medium.copyWith(
                              fontSize: heading2,
                              color: mainColor,
                            ),
                          ),
                          Text(
                            state.orders
                                .where((item) => item.status == "telat")
                                .length
                                .toString(),
                            style: medium.copyWith(
                              fontSize: heading,
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              const TitleSection(text: "Pesanan belum selesai"),
              const SizedBox(
                height: defaultMargin / 2,
              ),
              ...state.orders
                  .where((item) =>
                      item.status == "pending" ||
                      item.status == "dicuci" ||
                      item.status == "telat")
                  .map((e) => [
                        TransactionWidget(laundry: widget.laundry,order: e),
                        const SizedBox(height: defaultMargin),
                      ])
                  .expand((pair) => pair)
                  .toList()
                ..removeLast(),
              const SizedBox(
                height: 70,
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(color: mainColor),
          );
        }
      },
    );
  }
}

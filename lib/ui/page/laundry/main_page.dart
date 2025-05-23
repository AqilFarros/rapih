part of '../page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddOrderPage(laundry: widget.laundry),
              ),
            );
          },
          child: CardWidget(
            content: Row(
              children: [
                Text(
                  "Make an order",
                  style: regular.copyWith(fontSize: heading2),
                ),
                const Spacer(),
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: heading1,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        const TitleSection(text: "Finance"),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        Column(
          children: [
            CardWidget(
              content: Row(
                children: [
                  Image.asset("asset/image/uang.png", height: 70),
                  const SizedBox(
                    width: defaultMargin,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total uang saat ini adalah",
                          style: medium.copyWith(fontSize: heading2),
                        ),
                        const SizedBox(
                          height: defaultMargin / 3,
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(widget.laundry.wallet!.balance),
                          style: semiBold.copyWith(
                            fontSize: heading1,
                            color: mainColor,
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
                        Icon(
                          Icons.trending_up_rounded,
                          size: 40,
                          color: greenColor,
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(widget.laundry.wallet!.income),
                          style: medium.copyWith(
                            fontSize: heading2,
                            color: greenColor,
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
                        Icon(
                          Icons.trending_down_rounded,
                          size: 40,
                          color: redColor,
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(widget.laundry.wallet!.expense),
                          style: medium.copyWith(
                            fontSize: heading2,
                            color: redColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        const TitleSection(text: "Order"),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoaded) {
              return Column(
                children: [
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
                                "${state.orders.where((item) => item.status == "pending" || item.status == "dicuci").length} pesanan belum selesai!",
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
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
                ],
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
        const SizedBox(
          height: 70,
        ),
      ],
    );
  }
}

part of '../page.dart';

class CashierHomePage extends StatefulWidget {
  const CashierHomePage({super.key});

  @override
  State<CashierHomePage> createState() => _CashierHomePageState();
}

class _CashierHomePageState extends State<CashierHomePage> {
  @override
  void initState() {
    context.read<OrderCubit>().getOrder(
        storeId:
            (context.read<UserCubit>().state as UserLoaded).user.laundry!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralHomePage(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                if (state.user.isAbsence == false) {
                  return CardWidget(
                    content: Row(
                      children: [
                        Image.asset("asset/image/jam.png", height: 70),
                        const SizedBox(
                          width: defaultMargin,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kamu belum absen hari ini!",
                              style: medium.copyWith(fontSize: heading2),
                            ),
                            const SizedBox(
                              height: defaultMargin / 2,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                absentDialog(
                                    context,
                                    ((context.read<UserCubit>()).state
                                            as UserLoaded)
                                        .user
                                        .laundry!);
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
                                "Absen Sekarang",
                                style: semiBold.copyWith(
                                  fontSize: heading4,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddOrderPage(
                      laundry: (context.read<UserCubit>().state as UserLoaded)
                          .user
                          .laundry!),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(
                    laundry: (context.read<UserCubit>().state as UserLoaded)
                        .user
                        .laundry!,
                  ),
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
          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state is OrderLoaded) {
                if (state.orders.isEmpty) {
                  return const Center();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardWidget(
                      content: Row(
                        children: [
                          Image.asset("asset/image/list.png", height: 70),
                          const SizedBox(
                            width: defaultMargin,
                          ),
                          Column(
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
                                onPressed: () {},
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
                        .map((e) => [
                              TransactionWidget(order: e),
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
          ),
        ],
      ),
    );
  }
}

void absentDialog(BuildContext context, Laundry laundry) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actions: [
        SecondaryButton(
          name: "absent",
          function: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AbsentPage(laundry: laundry),
              ),
            );
          },
        ),
        PrimaryButton(
          name: "attend",
          function: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AttendPage(laundry: laundry),
              ),
            );
          },
        ),
      ],
      title: Text(
        "What is your absence status today?",
        style: medium.copyWith(fontSize: heading2),
      ),
    ),
  );
}

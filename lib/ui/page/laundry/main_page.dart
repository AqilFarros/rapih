part of '../page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.laundry});

  final Laundry laundry;

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
                builder: (context) => AddOrderPage(laundry: laundry),
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
                  Column(
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
                        ).format(laundry.wallet!.balance),
                        style: semiBold.copyWith(
                          fontSize: heading1,
                          color: mainColor,
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
                          ).format(laundry.wallet!.income),
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
                          ).format(laundry.wallet!.expense),
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
                    "12 pesanan belum selesai!",
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
                      "Belum selesai",
                      style: medium.copyWith(
                        fontSize: heading2,
                        color: mainColor,
                      ),
                    ),
                    Text(
                      "7",
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
                      "5",
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
          height: 70,
        ),
      ],
    );
  }
}

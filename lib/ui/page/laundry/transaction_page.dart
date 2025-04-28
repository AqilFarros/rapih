part of '../page.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardWidget(
          content: Row(
            children: [
              Text(
                "Search an order",
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
          height: defaultMargin,
        ),
        const TitleSection(text: "Pesanan belum selesai"),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        TransactionWidget(),
        const SizedBox(
          height: defaultMargin,
        ),
        TransactionWidget(),
        const SizedBox(
          height: defaultMargin,
        ),
        TransactionWidget(),
        const SizedBox(
          height: defaultMargin,
        ),
        TransactionWidget(),
        const SizedBox(
          height: defaultMargin,
        ),
        const SizedBox(
          height: 70,
        ),
      ],
    );
  }
}

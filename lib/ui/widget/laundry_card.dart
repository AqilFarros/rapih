part of 'widget.dart';

class LaundryCard extends StatelessWidget {
  const LaundryCard({super.key, required this.laundry});

  final Laundry laundry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GeneralLaundryPage(
              laundry: laundry,
            ),
          ),
        );
      },
      child: CardWidget(
        content: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        laundry.name,
                        style: medium.copyWith(
                          fontSize: heading4,
                          color: blackColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        laundry.address,
                        style: regular.copyWith(
                          fontSize: description,
                          color: grayColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(),
                Container(
                  width: 140,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        '$imageUrl/${laundry.picture}',
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(defaultMargin),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(laundry.wallet != null
                              ? laundry.wallet!.balance
                              : 0),
                          style: medium.copyWith(
                            fontSize: heading1,
                            color: mainColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Icon(
                //       CupertinoIcons.person,
                //       size: 32,
                //       color: mainColor,
                //     ),
                //     Text(
                //       "10",
                //       style: medium.copyWith(
                //         fontSize: heading1,
                //         color: mainColor,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

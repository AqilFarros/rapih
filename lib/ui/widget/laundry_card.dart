part of 'widget.dart';

class LaundryCard extends StatefulWidget {
  const LaundryCard({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<LaundryCard> createState() => _LaundryCardState();
}

class _LaundryCardState extends State<LaundryCard> {
  @override
  void initState() {
    context.read<WalletCubit>().getWallet(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GeneralLaundryPage(
              laundry: widget.laundry,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.laundry.name,
                      style: medium.copyWith(
                        fontSize: heading4,
                        color: blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      widget.laundry.address,
                      style: regular.copyWith(
                        fontSize: description,
                        color: grayColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
                Container(
                  width: 140,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        '$imageUrl/${widget.laundry.picture}',
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
                        BlocBuilder<WalletCubit, WalletState>(
                            builder: (context, state) {
                          if (state is WalletLoaded) {
                            return Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(state.wallet.balance),
                              style: medium.copyWith(
                                fontSize: heading1,
                                color: mainColor,
                              ),
                            );
                          } else if (state is WalletLoadedFailed) {
                            return const Text("");
                          } else {
                            return CircularProgressIndicator(color: mainColor,);
                          }
                        }),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.person,
                      size: 32,
                      color: mainColor,
                    ),
                    Text(
                      "10",
                      style: medium.copyWith(
                        fontSize: heading1,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

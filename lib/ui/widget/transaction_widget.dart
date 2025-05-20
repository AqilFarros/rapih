part of 'widget.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key, required this.laundry,required this.order});

  final Laundry laundry;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OrderDetailPage(laundry: laundry, order: order)),
        );
      },
      child: CardWidget(
        content: Row(
          children: [
            Image.asset(
              'asset/icon/laundry-machine.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: defaultMargin,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.customer.name,
                  style: medium.copyWith(
                    fontSize: heading4,
                    color: blackColor,
                  ),
                ),
                Text(
                  order.orderCode,
                  style: medium.copyWith(
                    fontSize: description,
                    color: grayColor,
                  ),
                ),
                Text(
                  order.status == 'bisa_diambil'
                      ? "bisa diambil"
                      : order.status,
                  style: medium.copyWith(
                    fontSize: description,
                    color: switch (order.status) {
                      "expired" => redColor,
                      "pending" => Colors.amber,
                      "bisa_diambil" => greenColor,
                      "dicuci" => secondaryColor,
                      "completed" => mainColor,
                      _ => grayColor,
                    },
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
              ).format(order.totalPrice),
              style: medium.copyWith(
                fontSize: heading2,
                color: mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

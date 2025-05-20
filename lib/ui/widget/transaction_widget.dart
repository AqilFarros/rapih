part of 'widget.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
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
                order.layanan.name,
                style: medium.copyWith(
                  fontSize: description,
                  color: grayColor,
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
    );
  }
}

part of '../widget.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key});

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
                "Bambang Yanto",
                style: medium.copyWith(
                  fontSize: heading4,
                  color: blackColor,
                ),
              ),
              Text(
                "1234567890123412",
                style: medium.copyWith(
                  fontSize: description,
                  color: grayColor,
                ),
              ),
              Text(
                "Cuci dan setrika",
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
            ).format(100000),
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

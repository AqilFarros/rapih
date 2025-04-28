part of '../widget.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({super.key});

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
                "Cuci dan setrika",
                style: medium.copyWith(
                  fontSize: heading4,
                  color: blackColor,
                ),
              ),
              Text(
                "2 hari",
                style: medium.copyWith(
                  fontSize: description,
                  color: grayColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "${NumberFormat.currency(
              locale: 'id',
              symbol: 'Rp ',
              decimalDigits: 0,
            ).format(10000)}/kg",
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

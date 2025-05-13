part of 'widget.dart';

class AttendHistoryWidget extends StatelessWidget {
  const AttendHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      content: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Aqil Farros Al Ghonim",
                style: semiBold.copyWith(
                  fontSize: heading2,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: defaultMargin / 4),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    size: heading2,
                    color: grayColor,
                  ),
                  Text(
                    " 12 November - 13 November",
                    style: medium.copyWith(
                      fontSize: heading3,
                      color: grayColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(
            width: defaultMargin,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('asset/image/karyawan.png'),
                radius: 30,
              ),
              const SizedBox(height: defaultMargin / 2),
              Text(
                "Sakit",
                style: medium.copyWith(
                  fontSize: heading3,
                  color: redColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

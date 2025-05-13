part of 'widget.dart';

class AbsentHistoryWidget extends StatelessWidget {
  const AbsentHistoryWidget({
    super.key,
    required this.absent,
  });

  final Absent absent;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      content: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                absent.name,
                style: semiBold.copyWith(
                  fontSize: heading2,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: defaultMargin / 4),
              Text(
                "Belum absen",
                style: medium.copyWith(
                  fontSize: heading3,
                  color: redColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(
            width: defaultMargin,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('asset/image/absence/tidak_hadir.png'),
            radius: 30,
          ),
        ],
      ),
    );
  }
}

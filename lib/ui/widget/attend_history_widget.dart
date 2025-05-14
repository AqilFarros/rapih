part of 'widget.dart';

class AttendHistoryWidget extends StatelessWidget {
  const AttendHistoryWidget({super.key, required this.attendance});

  final Attend attendance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AbsenceDetailPage(attendance: attendance),
          ),
        );
      },
      child: CardWidget(
        content: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attendance.name,
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
                      attendance.fromDate != ""
                          ? " ${formatDateMonthYear(attendance.fromDate!)} - ${formatDateMonthYear(attendance.toDate!)}"
                          : " ${convertToHourMinute(attendance.createdAt!)}, ${formatDate(attendance.createdAt!)}",
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
                  backgroundImage: switch (attendance.status) {
                    'hadir' => NetworkImage('$imageUrl/${attendance.image}'),
                    'izin' => const AssetImage('asset/image/absence/izin.jpg'),
                    'sakit' =>
                      const AssetImage('asset/image/absence/sakit.jpg'),
                    _ => const AssetImage('asset/image/absence/izin.jpg'),
                  },
                  radius: 30,
                ),
                const SizedBox(height: defaultMargin / 2),
                Text(
                  attendance.status,
                  style: medium.copyWith(
                    fontSize: heading3,
                    color: switch (attendance.status) {
                      'hadir' => mainColor,
                      'izin' => secondaryColor,
                      'sakit' => redColor,
                      _ => mainColor,
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

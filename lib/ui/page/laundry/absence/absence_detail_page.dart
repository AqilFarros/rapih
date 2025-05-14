part of '../../page.dart';

class AbsenceDetailPage extends StatelessWidget {
  const AbsenceDetailPage({super.key, required this.attendance});

  final Attend attendance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Absence',
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: attendance.status != 'hadir'
              ? AbsentDetail(
                  attendance: attendance,
                )
              : AttendDetail(
                  attendance: attendance,
                ),
        ),
      ),
    );
  }
}

class AttendDetail extends StatelessWidget {
  const AttendDetail({super.key, required this.attendance});

  final Attend attendance;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      content: Column(
        children: [
          const SizedBox(height: defaultMargin),
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultMargin),
              image: DecorationImage(
                image: NetworkImage('$imageUrl/${attendance.image}'),
              ),
            ),
          ),
          const SizedBox(height: defaultMargin),
          Text(
            attendance.name,
            style: semiBold.copyWith(
              fontSize: heading2,
              color: mainColor,
            ),
          ),
          Text(
            " ${convertToHourMinute(attendance.createdAt!)}, ${formatDate(attendance.createdAt!)}",
            style: medium.copyWith(
              fontSize: heading3,
              color: grayColor,
            ),
          ),
        ],
      ),
    );
  }
}

class AbsentDetail extends StatelessWidget {
  const AbsentDetail({super.key, required this.attendance});

  final Attend attendance;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      content: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (attendance.status) {
                  'izin' => const AssetImage('asset/image/absence/izin.jpg'),
                  'sakit' => const AssetImage('asset/image/absence/sakit.jpg'),
                  _ => const AssetImage('asset/image/absence/izin.jpg'),
                },
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(defaultMargin),
            ),
          ),
          const SizedBox(height: defaultMargin),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                attendance.name,
                style: semiBold.copyWith(fontSize: heading1, color: mainColor),
              ),
              const SizedBox(width: 5),
              Text(
                "(${attendance.status})",
                style: medium.copyWith(
                  fontSize: heading2,
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
          const SizedBox(height: defaultMargin / 3),
          Row(
            children: [
              Icon(
                Icons.timer,
                size: heading2,
                color: grayColor,
              ),
              Text(
                " ${formatDateMonthYear(attendance.fromDate!)} - ${formatDateMonthYear(attendance.toDate!)}",
                style: medium.copyWith(
                  fontSize: heading3,
                  color: grayColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultMargin / 3),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 20,
                color: grayColor,
              ),
              Text(
                " Permittor name:",
                style: medium.copyWith(
                  fontSize: heading3,
                  color: grayColor,
                ),
              ),
              Text(
                " ${attendance.permittorName}",
                style: semiBold.copyWith(fontSize: heading3, color: mainColor),
              ),
            ],
          ),
          const SizedBox(height: defaultMargin / 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.description_outlined,
                size: 20,
                color: grayColor,
              ),
              Text(
                " Alasan izin: ",
                style: medium.copyWith(
                  fontSize: heading3,
                  color: grayColor,
                ),
              ),
              Expanded(
                child: Text(
                  attendance.reason!,
                  style: regular.copyWith(fontSize: heading3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

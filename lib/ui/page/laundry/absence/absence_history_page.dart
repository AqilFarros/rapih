part of '../../page.dart';

class AbsenceHistoryPage extends StatefulWidget {
  const AbsenceHistoryPage({
    super.key,
    required this.laundry,
  });

  final Laundry laundry;

  @override
  State<AbsenceHistoryPage> createState() => _AbsenceHistoryPageState();
}

class _AbsenceHistoryPageState extends State<AbsenceHistoryPage> {
  final startController = TextEditingController();
  final endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Absence History',
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InputField(
                    label: "Start",
                    controller: startController,
                    hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    icon: Icons.calendar_today_outlined,
                    validator: (String? value) {},
                  ),
                ),
                const SizedBox(width: defaultMargin / 2),
                Expanded(
                  child: InputField(
                    label: "End",
                    controller: endController,
                    hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    icon: Icons.calendar_today_outlined,
                    validator: (String? value) {},
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultMargin),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleSection(text: "Sudah absen"),
                  const SizedBox(height: defaultMargin / 2),
                  // AttendHistoryWidget(),
                  const SizedBox(height: defaultMargin),
                  const TitleSection(text: "Belum absen"),
                  const SizedBox(height: defaultMargin / 2),
                  // AbsentHistoryWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

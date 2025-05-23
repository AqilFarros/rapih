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
  bool isLoading = false;

  Future<void> selectDate({required TextEditingController controller}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null && !isLoading) {
      controller.text = DateFormat("dd-MM-yyyy").format(picked);
      context.read<AbsenceCubit>().getAbsence(
            storeId: widget.laundry.id,
            startDate: startController.text,
            endDate: endController.text,
          );
    }
  }

  @override
  void initState() {
    startController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    endController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

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
                    onTap: () {
                      selectDate(controller: startController);
                    },
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
                    onTap: () {
                      selectDate(controller: endController);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultMargin),
            BlocListener<AbsenceCubit, AbsenceState>(
              listener: (context, state) {
                if (state is AbsenceLoaded) {
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: BlocBuilder<AbsenceCubit, AbsenceState>(
                builder: (context, state) {
                  if (state is AbsenceLoaded) {
                    return Expanded(
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleSection(text: "Sudah absen"),
                          const SizedBox(height: defaultMargin / 2),
                          ...state.absence.attendList.expand((item) => [
                                AttendHistoryWidget(attendance: item),
                                const SizedBox(height: defaultMargin),
                              ]),
                          const SizedBox(height: defaultMargin),
                          const TitleSection(text: "Belum absen"),
                          const SizedBox(height: defaultMargin / 2),
                          ...state.absence.absentList.expand((item) => [
                                AbsentHistoryWidget(absent: item),
                                const SizedBox(height: defaultMargin),
                              ]),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

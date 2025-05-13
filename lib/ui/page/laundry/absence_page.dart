part of '../page.dart';

class AbsencePage extends StatefulWidget {
  const AbsencePage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<AbsencePage> createState() => _AbsencePageState();
}

class _AbsencePageState extends State<AbsencePage> {
  @override
  void initState() {
    context.read<CashierCubit>().getCashier(storeId: widget.laundry.id);
    context.read<AbsenceCubit>().getAbsence(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CashierCubit, CashierState>(
          builder: (context, state) {
            if (state is CashierLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ManageWidget(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CashirePage(laundry: widget.laundry),
                        ),
                      );
                    },
                    text: "Manage cashier",
                    image: "asset/icon/cashier.png",
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  CardWidget(
                    content: Row(
                      children: [
                        Image.asset("asset/icon/cashier.png", height: 70),
                        const SizedBox(
                          width: defaultMargin,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saat ini kita memiliki",
                              style: medium.copyWith(fontSize: heading2),
                            ),
                            const SizedBox(
                              height: defaultMargin / 3,
                            ),
                            Text(
                              "${state.cashier.length} Kasir",
                              style: semiBold.copyWith(
                                fontSize: heading1,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CardWidget(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Telah absen",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                  color: mainColor,
                                ),
                              ),
                              Text(
                                "7",
                                style: medium.copyWith(
                                  fontSize: heading,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: defaultMargin,
                      ),
                      Expanded(
                        child: CardWidget(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Belum absen",
                                style: medium.copyWith(
                                  fontSize: heading2,
                                  color: mainColor,
                                ),
                              ),
                              Text(
                                "5",
                                style: medium.copyWith(
                                  fontSize: heading,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultMargin,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SecondaryButton(
                      name: "Riwayat absensi",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AbsenceHistoryPage(laundry: widget.laundry),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
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
      ],
    );
  }
}

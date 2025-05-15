part of '../page.dart';

class CashierHomePage extends StatelessWidget {
  const CashierHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralHomePage(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                if (state.user.isAbsence == false) {
                  return CardWidget(
                    content: Row(
                      children: [
                        Image.asset("asset/image/jam.png", height: 70),
                        const SizedBox(
                          width: defaultMargin,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kamu belum absen hari ini!",
                              style: medium.copyWith(fontSize: heading2),
                            ),
                            const SizedBox(
                              height: defaultMargin / 2,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                absentDialog(
                                    context,
                                    ((context.read<UserCubit>()).state
                                            as UserLoaded)
                                        .user
                                        .laundry!);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: defaultMargin,
                                  vertical: defaultMargin / 3,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                "Absen Sekarang",
                                style: semiBold.copyWith(
                                  fontSize: heading4,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}

void absentDialog(BuildContext context, Laundry laundry) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actions: [
        SecondaryButton(
          name: "absent",
          function: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AbsentPage(laundry: laundry),
              ),
            );
          },
        ),
        PrimaryButton(
          name: "attend",
          function: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AttendPage(laundry: laundry),
              ),
            );
          },
        ),
      ],
      title: Text(
        "What is your absence status today?",
        style: medium.copyWith(fontSize: heading2),
      ),
    ),
  );
}

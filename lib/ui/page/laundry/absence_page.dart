part of '../page.dart';

class AbsencePage extends StatelessWidget {
  const AbsencePage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ManageWidget(onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CashirePage(laundry: laundry),
            ),
          );
        },text: "Manage cashier", image:"asset/icon/cashier.png",),
        const SizedBox(
          height: defaultMargin,
        ),
        CardWidget(
          content: Row(
            children: [
              Image.asset("asset/image/karyawan.png", height: 70),
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
                    "12 Karyawan",
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
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: PrimaryButton(
            name: "Promosikan Karyawan",
            function: () {},
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
        Row(
          children: [
            Expanded(
              child: CardWidget(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tepat waktu",
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
                      "Terlambat",
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
          child: PrimaryButton(
            name: "Lihat detail",
            function: () {},
          ),
        ),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SecondaryButton(
            name: "Riwayat absensi",
            function: () {},
          ),
        ),
        const SizedBox(
          height: 70,
        ),
      ],
    );
  }
}

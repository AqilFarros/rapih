part of '../../page.dart';

class CashirePage extends StatefulWidget {
  const CashirePage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<CashirePage> createState() => _CashirePageState();
}

class _CashirePageState extends State<CashirePage> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<CashierCubit>().getCashier(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Cashier",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultMargin),
          ManageWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCashierPage(
                    laundry: widget.laundry,
                  ),
                ),
              );
            },
            text: "Add a new cashier",
            image: "asset/icon/cashier.png",
          ),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current Cashier"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<CashierCubit, CashierState>(
            builder: (context, state) {
              if (state is CashierLoaded) {
                if (state.cashier.isEmpty) {
                  return AddIllustrationWidget(
                    image: 'asset/icon/cashier.png',
                    text: "a cashier",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCashierPage(
                            laundry: widget.laundry,
                          ),
                        ),
                      );
                    },
                  );
                }
                return isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      )
                    : LayoutBuilder(builder: (context, constraints) {
                        double itemWidth =
                            (constraints.maxWidth - defaultMargin) / 2;
                        return Wrap(
                          spacing: defaultMargin,
                          runSpacing: defaultMargin,
                          children: List.generate(
                            state.cashier.length,
                            (index) => SizedBox(
                              width: itemWidth,
                              child: ManageCard(
                                title: "Name kasir",
                                image: "asset/icon/cashier.png",
                                edit: () {},
                                delete: () async {
                                  if (!isLoading) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    await context
                                        .read<CashierCubit>()
                                        .deleteCashier(
                                          storeId: widget.laundry.id,
                                          cashierId: state.cashier[index].id,
                                        );

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                widget: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 10,
                                        color:
                                            state.cashier[index].isActive == 1
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      const SizedBox(
                                        width: defaultMargin / 2,
                                      ),
                                      Text(
                                        state.cashier[index].isActive == 1
                                            ? "Active"
                                            : "Not active",
                                        style:
                                            medium.copyWith(fontSize: heading3),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
              } else if (state is CashierLoadedFailed) {
                return Text(state.message);
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
      ),
    );
  }
}

part of '../../../page.dart';

class ParfumePage extends StatefulWidget {
  const ParfumePage({super.key, required this.laundry, this.isOrder = false});

  final Laundry laundry;
  final bool? isOrder;

  @override
  State<ParfumePage> createState() => _ParfumePageState();
}

class _ParfumePageState extends State<ParfumePage> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<ParfumeCubit>().getParfume(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Parfume",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultMargin),
          ManageWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateParfumePage(
                    laundry: widget.laundry,
                  ),
                ),
              );
            },
            text: "Add a new parfume",
            image: "asset/icon/parfume.png",
          ),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current parfume"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<ParfumeCubit, ParfumeState>(
            builder: (context, state) {
              if (state is ParfumeLoaded) {
                if (state.parfume.isEmpty) {
                  return AddIllustrationWidget(
                    image: 'asset/icon/parfume.png',
                    text: "a parfume",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateParfumePage(
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
                            state.parfume.length,
                            (index) => SizedBox(
                              width: itemWidth,
                              child: ManageCard(
                                isOrder: widget.isOrder,
                                data: state.parfume[index],
                                title: state.parfume[index].name,
                                image: "asset/icon/parfume.png",
                                edit: () {
                                  if (!isLoading) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditParfumePage(
                                          laundry: widget.laundry,
                                          parfume: state.parfume[index],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                delete: () async {
                                  if (!isLoading) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    await context
                                        .read<ParfumeCubit>()
                                        .deleteParfume(
                                            storeId: widget.laundry.id,
                                            parfumeId: state.parfume[index].id);

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                widget: [
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp',
                                      decimalDigits: 0,
                                    ).format(state.parfume[index].price),
                                    style: medium.copyWith(
                                      fontSize: heading3,
                                      color: mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
              } else if (state is ParfumeLoadedFailed) {
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
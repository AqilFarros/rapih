part of '../../../page.dart';

class LayananPage extends StatefulWidget {
  const LayananPage({super.key, required this.laundry, this.isOrder = false});

  final Laundry laundry;
  final bool? isOrder;

  @override
  State<LayananPage> createState() => _LayananPageState();
}

class _LayananPageState extends State<LayananPage> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<LayananCubit>().getLayanan(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Layanan",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultMargin),
          (context.read<UserCubit>().state as UserLoaded).user.role == "owner"
          ?
          ManageWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateLayananPage(
                    laundry: widget.laundry,
                  ),
                ),
              );
            },
            text: "Add a new layanan",
            image: "asset/icon/layanan.png",
          )
          :
          const SizedBox(),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current layanan"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<LayananCubit, LayananState>(
            builder: (context, state) {
              if (state is LayananLoaded) {
                if (state.layanan.isEmpty && (context.read<UserCubit>().state as UserLoaded).user.role == "owner") {
                  return AddIllustrationWidget(
                    image: 'asset/icon/layanan.png',
                    text: "a layanan",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateLayananPage(
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
                            state.layanan.length,
                            (index) => SizedBox(
                              width: itemWidth,
                              child: ManageCard(
                                isOrder: widget.isOrder,
                                data: state.layanan[index],
                                title: state.layanan[index].name,
                                image: "asset/icon/layanan.png",
                                edit: () {
                                  if (!isLoading) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditLayananPage(
                                          laundry: widget.laundry,
                                          layanan: state.layanan[index],
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
                                        .read<LayananCubit>()
                                        .deleteLayanan(
                                            storeId: widget.laundry.id,
                                            layananId: state.layanan[index].id);

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                widget: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: mainColor,
                                        size: heading2,
                                      ),
                                      const SizedBox(width: defaultMargin / 4),
                                      Expanded(
                                        child: Text(
                                          "${state.layanan[index].duration.toString()} jam",
                                          style: medium.copyWith(
                                            fontSize: heading3,
                                            color: mainColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
              } else if (state is LayananLoadedFailed) {
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

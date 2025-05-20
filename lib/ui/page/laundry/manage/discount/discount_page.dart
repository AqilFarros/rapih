part of '../../../page.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({
    super.key,
    required this.laundry,
    this.isOrder = false,
  });

  final Laundry laundry;
  final bool? isOrder;

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<DiscountCubit>().getDiscount(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Discount",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultMargin),
          (context.read<UserCubit>().state as UserLoaded).user.role == "owner"
              ? ManageWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateDiscountPage(
                          laundry: widget.laundry,
                        ),
                      ),
                    );
                  },
                  text: "Add a new discount",
                  image: "asset/icon/discount.png",
                )
              : const SizedBox(),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current discount"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<DiscountCubit, DiscountState>(
            builder: (context, state) {
              if (state is DiscountLoaded) {
                if (state.discount.isEmpty &&
                    (context.read<UserCubit>().state as UserLoaded).user.role ==
                        "owner") {
                  return AddIllustrationWidget(
                    image: 'asset/icon/discount.png',
                    text: "a discount",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateDiscountPage(
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
                            state.discount.length,
                            (index) => SizedBox(
                              width: itemWidth,
                              child: ManageCard(
                                isOrder: widget.isOrder,
                                data: state.discount[index],
                                title: state.discount[index].name,
                                image: "asset/icon/discount.png",
                                edit: () {
                                  if (!isLoading) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditDiscountPage(
                                          laundry: widget.laundry,
                                          discount: state.discount[index],
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
                                        .read<DiscountCubit>()
                                        .deleteDiscount(
                                            storeId: widget.laundry.id,
                                            discountId:
                                                state.discount[index].id);

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
                                    ).format(state.discount[index].amount),
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
              } else if (state is DiscountLoadedFailed) {
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

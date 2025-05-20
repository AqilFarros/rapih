part of '../../../page.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key, required this.laundry, this.isOrder = false,});

  final Laundry laundry;
  final bool? isOrder;

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<DeliveryCubit>().getDelivery(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Delivery",
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
                  builder: (context) => CreateDeliveryPage(
                    laundry: widget.laundry,
                  ),
                ),
              );
            },
            text: "Add a new delivery",
            image: "asset/icon/delivery.png",
          )
          :
          const SizedBox(),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current delivery"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<DeliveryCubit, DeliveryState>(
            builder: (context, state) {
              if (state is DeliveryLoaded) {
                if (state.delivery.isEmpty && (context.read<UserCubit>().state as UserLoaded).user.role == "owner") {
                  return AddIllustrationWidget(
                    image: 'asset/icon/delivery.png',
                    text: "a delivery",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateDeliveryPage(
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
                            state.delivery.length,
                            (index) => SizedBox(
                              width: itemWidth,
                              child: ManageCard(
                                isOrder: widget.isOrder,
                                data: state.delivery[index],
                                title: state.delivery[index].name,
                                image: "asset/icon/delivery.png",
                                edit: () {
                                  if (!isLoading) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditDeliveryPage(
                                          laundry: widget.laundry,
                                          delivery: state.delivery[index],
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
                                        .read<DeliveryCubit>()
                                        .deleteDelivery(
                                            storeId: widget.laundry.id,
                                            deliveryId: state.delivery[index].id);

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
                                    ).format(state.delivery[index].amount),
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
              } else if (state is DeliveryLoadedFailed) {
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
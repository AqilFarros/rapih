part of '../../../page.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key, required this.laundry, this.isOrder = false});
  final Laundry laundry;
  final bool? isOrder;

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<CustomerCubit>().getCustomer(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Customer",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultMargin),
          ManageWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateCustomerPage(
                          laundry: widget.laundry,
                        ),
                      ),
                    );
                  },
                  text: "Add a new customer",
                  image: "asset/icon/customer.png",
                ),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current Customer"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<CustomerCubit, CustomerState>(
            builder: (context, state) {
              if (state is CustomerLoaded) {
                if (state.customer.isEmpty) {
                  return AddIllustrationWidget(
                    image: 'asset/icon/customer.png',
                    text: "a customer",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateCustomerPage(
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
                            state.customer.length,
                            (index) => SizedBox(
                              width: itemWidth,
                              child: ManageCard(
                                isOrder: widget.isOrder,
                                data: state.customer[index],
                                title: state.customer[index].name,
                                image: "asset/icon/customer.png",
                                widget: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: mainColor,
                                        size: heading2,
                                      ),
                                      const SizedBox(width: defaultMargin / 4),
                                      Expanded(
                                        child: Text(
                                          state.customer[index].address,
                                          style: medium.copyWith(
                                              fontSize: heading3),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: mainColor,
                                        size: heading2,
                                      ),
                                      const SizedBox(width: defaultMargin / 4),
                                      Expanded(
                                        child: Text(
                                          state.customer[index].number,
                                          style: medium.copyWith(
                                              fontSize: heading3),
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
              } else if (state is CustomerLoadedFailed) {
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

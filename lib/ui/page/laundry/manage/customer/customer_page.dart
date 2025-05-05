part of '../../../page.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key, required this.laundry});
  final Laundry laundry;

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
                              child: CardWidget(
                                content: Column(
                                  children: [
                                    Image.asset("asset/icon/customer.png"),
                                    const SizedBox(height: defaultMargin / 2),
                                    Text(
                                      state.customer[index].name,
                                      style:
                                          medium.copyWith(fontSize: heading1),
                                    ),
                                    const SizedBox(height: defaultMargin / 2),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: SecondaryButton(
                                        name: "Edit",
                                        function: () {
                                          // if (!isLoading) {
                                          //   Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           EditCustomerPage(
                                          //         laundry: widget.laundry,
                                          //         category:
                                          //             state.customer[index],
                                          //       ),
                                          //     ),
                                          //   );
                                          // }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: PrimaryButton(
                                        name: "Delete",
                                        function: () async {
                                          // if (!isLoading) {
                                          //   setState(() {
                                          //     isLoading = true;
                                          //   });

                                          //   await context
                                          //       .read<CustomerCubit>()
                                          //       .deleteCategory(
                                          //           storeId: widget.laundry.id,
                                          //           categoryId: state
                                          //               .customer[index].id);

                                          //   setState(() {
                                          //     isLoading = false;
                                          //   });
                                          // }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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

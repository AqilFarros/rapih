part of '../../page.dart';

class SearchOrderPage extends StatefulWidget {
  const SearchOrderPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<SearchOrderPage> createState() => _SearchOrderPageState();
}

class _SearchOrderPageState extends State<SearchOrderPage> {
  final orderCodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<OrderQueryCubit>().emitInitial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Order',
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: CardWidget(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InputField(
                      label: "Kode pesanan",
                      controller: orderCodeController,
                      hintText: "Kode pesanan",
                      validator: (value) =>
                          requiredValidator(value, "Kode pesanan"),
                    ),
                    const SizedBox(height: defaultMargin / 2),
                    isLoading == false
                        ? PrimaryButton(
                            name: "Cari",
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                await context
                                    .read<OrderQueryCubit>()
                                    .getOrderByQuery(
                                        storeId: widget.laundry.id,
                                        query: orderCodeController.text);

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                          )
                        : CircularProgressIndicator(
                            color: mainColor,
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            Expanded(
              child: BlocBuilder<OrderQueryCubit, OrderQueryState>(
                builder: (context, state) {
                  if (state is OrderQueryLoaded) {
                    if (state.orders.isEmpty) {
                      return Center(
                        child: Text(
                          "Pesanan tidak ditemukan.",
                          style: medium.copyWith(fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: defaultMargin),
                      itemCount: state.orders.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Total pesanan:",
                                    style: medium.copyWith(fontSize: heading2),
                                  ),
                                  Text(
                                    " ${state.orders.length}",
                                    style: semiBold.copyWith(
                                      fontSize: heading2,
                                      color: mainColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: defaultMargin),
                            ],
                          );
                        }

                        final order = state.orders[index - 1];
                        return Column(
                          children: [
                            TransactionWidget(
                                laundry: widget.laundry, order: order),
                            const SizedBox(height: defaultMargin),
                          ],
                        );
                      },
                    );
                  } else if (state is OrderQueryInitial) {
                    return Center(
                      child: CircularProgressIndicator(color: mainColor),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

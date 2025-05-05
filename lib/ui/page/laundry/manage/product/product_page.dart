part of '../../../page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.laundry});
  final Laundry laundry;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<ProductCubit>().getProduct(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Product",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultMargin),
          ManageWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateProductPage(
                    laundry: widget.laundry,
                  ),
                ),
              );
            },
            text: "Add a new product",
            image: "asset/icon/laundry-machine.png",
          ),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current product"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                if (state.product.isEmpty) {
                  return AddIllustrationWidget(
                    image: 'asset/icon/laundry-machine.png',
                    text: "a product",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateProductPage(
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
                            state.product.length,
                            (index) => SizedBox(
                              width: itemWidth,
                              child: CardWidget(
                                content: Column(
                                  children: [
                                    Image.asset(
                                        "asset/icon/laundry-machine.png"),
                                    const SizedBox(height: defaultMargin / 2),
                                    Text(
                                      state.product[index].name,
                                      style:
                                          medium.copyWith(fontSize: heading1),
                                    ),
                                    const SizedBox(height: defaultMargin / 2),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: SecondaryButton(
                                        name: "Edit",
                                        function: () {
                                          if (!isLoading) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProductPage(
                                                  laundry: widget.laundry,
                                                  product: state.product[index],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: PrimaryButton(
                                        name: "Delete",
                                        function: () async {
                                          if (!isLoading) {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            await context
                                                .read<ProductCubit>()
                                                .deleteProduct(
                                                    storeId: widget.laundry.id,
                                                    productId: state
                                                        .product[index].id);

                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
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
              } else if (state is ProductLoadedFailed) {
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

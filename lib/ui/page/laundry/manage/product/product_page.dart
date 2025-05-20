part of '../../../page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.laundry, this.isOrder = false});

  final Laundry laundry;
  final bool? isOrder;

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
          (context.read<UserCubit>().state as UserLoaded).user.role == "owner"
              ? ManageWidget(
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
                )
              : const SizedBox(),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current product"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                if (state.product.isEmpty &&
                    (context.read<UserCubit>().state as UserLoaded).user.role ==
                        "owner") {
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
                              child: ManageCard(
                                isOrder: widget.isOrder,
                                data: state.product[index],
                                title: state.product[index].name,
                                image: "asset/icon/laundry-machine.png",
                                edit: () {
                                  if (!isLoading) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProductPage(
                                          laundry: widget.laundry,
                                          product: state.product[index],
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
                                        .read<ProductCubit>()
                                        .deleteProduct(
                                            storeId: widget.laundry.id,
                                            productId: state.product[index].id);

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
                                    ).format(state.product[index].price),
                                    style: medium.copyWith(
                                      fontSize: heading3,
                                      color: mainColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'asset/icon/category.png',
                                        width: heading2,
                                      ),
                                      const SizedBox(width: defaultMargin / 4),
                                      Text(
                                        state.product[index].categoryName,
                                        style:
                                            medium.copyWith(fontSize: heading3),
                                      )
                                    ],
                                  ),
                                ],
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

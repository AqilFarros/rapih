part of '../../../page.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({
    super.key,
    required this.laundry,
    required this.product,
  });

  final Laundry laundry;
  final Product product;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int? selectedCategory;

  @override
  void initState() {
    context.read<CategoryCubit>().getCategory(storeId: widget.laundry.id);
    nameController.text = widget.product.name;
    priceController.text = widget.product.price.toString();
    selectedCategory = widget.product.categoryId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Edit Product",
      widget: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, categoryState) {
          if (categoryState is CategoryLoaded) {
            if (categoryState.category.isEmpty) {
              return AddIllustrationWidget(
                image: 'asset/icon/category.png',
                text: "a category",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateCategoryPage(
                        laundry: widget.laundry,
                      ),
                    ),
                  );
                },
              );
            } else {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: defaultMargin,
                    ),
                    InputField(
                      label: "Name",
                      controller: nameController,
                      hintText: "Name",
                      icon: Icons.production_quantity_limits_rounded,
                      validator: (value) {
                        return requiredValidator(value, "Name");
                      },
                    ),
                    const SizedBox(
                      height: defaultMargin,
                    ),
                    InputField(
                      label: "Price",
                      controller: priceController,
                      hintText: "10000",
                      icon: Icons.monetization_on_outlined,
                      validator: (value) {
                        return numberValidator(value, "Price");
                      },
                    ),
                    const SizedBox(
                      height: defaultMargin,
                    ),
                    DropdownWidget<int, Category>(
                      label: "Category",
                      selectedValue: selectedCategory,
                      items: categoryState.category,
                      getLabel: (item) => item.name,
                      getValue: (item) => item.id,
                      onChanged: (item) {
                        setState(() {
                          selectedCategory = item;
                        });
                      },
                      validator: (value) =>
                          value == null ? "Please select a category" : null,
                      icon: Icons.category_outlined,
                    ),
                    const SizedBox(
                      height: defaultMargin,
                    ),
                    BlocConsumer<ProductCubit, ProductState>(
                      listener: (context, state) {
                        if (state is ProductLoaded) {
                          Navigator.pop(context);
                        } else {}
                      },
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: isLoading
                              ? [
                                  CircularProgressIndicator(
                                    color: mainColor,
                                  ),
                                ]
                              : [
                                  SecondaryButton(
                                    name: "Cancel",
                                    function: () {
                                      if (isLoading) {
                                        return;
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    width: defaultMargin,
                                  ),
                                  PrimaryButton(
                                    name: "Edit",
                                    function: () async {
                                      if (isLoading) {
                                        return;
                                      } else {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });

                                          await context
                                              .read<ProductCubit>()
                                              .editProduct(
                                                name: nameController.text,
                                                productId: widget.product.id,
                                                storeId: widget.laundry.id,
                                                categoryId: selectedCategory!,
                                                price: int.parse(
                                                    priceController.text),
                                              );

                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          } else {
            return Container(
              margin: const EdgeInsets.all(defaultMargin),
              child: Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

part of '../../../page.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key, required this.laundry});
  final Laundry laundry;

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int? selectedCategory;

  @override
  void initState() {
    context.read<CategoryCubit>().getCategory(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Create Product",
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
              if (selectedCategory == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    selectedCategory = categoryState.category[0].id;
                  });
                });
              }
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: defaultMargin,
                    ),
                    InputField(
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
                                    name: "Create",
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
                                              .addProduct(
                                                name: nameController.text,
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

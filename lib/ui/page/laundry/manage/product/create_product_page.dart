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
                        requiredValidator(value, "Name");
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
                        numberValidator(value, "Price");
                      },
                    ),
                    const SizedBox(
                      height: defaultMargin,
                    ),
                    DropdownButtonFormField<int>(
                      value: selectedCategory,
                      isExpanded: true,
                      items: categoryState.category
                          .map(
                            (item) => DropdownMenuItem(
                              value: item.id,
                              child: Text(
                                item.name,
                                style: regular.copyWith(color: blackColor),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedCategory = item;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteColor,
                        prefixIcon: const Icon(Icons.category_rounded),
                        hintText: "Select Category",
                        hintStyle: light,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultMargin / 2),
                          borderSide: BorderSide(color: whiteSmokeColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultMargin / 2),
                          borderSide: BorderSide(color: mainColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultMargin / 2),
                          borderSide: BorderSide(color: redColor),
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      dropdownColor: whiteColor,
                      style: regular,
                      validator: (value) =>
                          value == null ? "Please select a category" : null,
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
                                                categoryId: 0,
                                                price: 0,
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
            return Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            );
          }
        },
      ),
    );
  }
}

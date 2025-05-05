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

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Create Product",
      widget: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: defaultMargin,
            ),
            InputField(
              controller: nameController,
              hintText: "Name",
              icon: Icons.category_rounded,
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

                                  await context.read<ProductCubit>().addProduct(
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
      ),
    );
  }
}

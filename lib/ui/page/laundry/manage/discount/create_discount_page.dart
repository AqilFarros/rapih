part of '../../../page.dart';

class CreateDiscountPage extends StatefulWidget {
  const CreateDiscountPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<CreateDiscountPage> createState() => _CreateDiscountPageState();
}

class _CreateDiscountPageState extends State<CreateDiscountPage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Create Discount",
      widget: Form(
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
              icon: Icons.discount_rounded,
              validator: (value) {
                return requiredValidator(value, "Name");
              },
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            InputField(
              label: "Amount",
              controller: amountController,
              hintText: "Amount",
              icon: Icons.monetization_on_rounded,
              validator: (value) {
                return numberValidator(value, "Amount");
              },
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            BlocConsumer<DiscountCubit, DiscountState>(
              listener: (context, state) {
                if (state is DiscountLoaded) {
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
                                      .read<DiscountCubit>()
                                      .addDiscount(
                                          name: nameController.text,
                                          amount: int.parse(amountController.text),
                                          storeId: widget.laundry.id,);

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
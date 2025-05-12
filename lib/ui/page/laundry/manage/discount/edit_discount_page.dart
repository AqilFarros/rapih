part of '../../../page.dart';

class EditDiscountPage extends StatefulWidget {
  const EditDiscountPage({
    super.key,
    required this.laundry,
    required this.discount,
  });

  final Laundry laundry;
  final Discount discount;

  @override
  State<EditDiscountPage> createState() => _EditDiscountPageState();
}

class _EditDiscountPageState extends State<EditDiscountPage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    nameController.text = widget.discount.name;
    amountController.text = widget.discount.amount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Edit Discount",
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
              textInputAction: TextInputAction.done,
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
                                      .read<DiscountCubit>()
                                      .editDiscount(
                                        name: nameController.text,
                                        amount:
                                            int.parse(amountController.text),
                                        discountId: widget.discount.id,
                                        storeId: widget.laundry.id,
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

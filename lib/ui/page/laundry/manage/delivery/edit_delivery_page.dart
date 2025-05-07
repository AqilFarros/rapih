part of '../../../page.dart';

class EditDeliveryPage extends StatefulWidget {
  const EditDeliveryPage({
    super.key,
    required this.laundry,
    required this.delivery,
  });

  final Laundry laundry;
  final Delivery delivery;

  @override
  State<EditDeliveryPage> createState() => _EditDeliveryPageState();
}

class _EditDeliveryPageState extends State<EditDeliveryPage> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    nameController.text = widget.delivery.name;
    amountController.text = widget.delivery.amount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Edit Delivery",
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
              icon: Icons.delivery_dining_rounded,
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
            BlocConsumer<DeliveryCubit, DeliveryState>(
              listener: (context, state) {
                if (state is DeliveryLoaded) {
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
                                      .read<DeliveryCubit>()
                                      .editDelivery(
                                        name: nameController.text,
                                        amount:
                                            int.parse(amountController.text),
                                        storeId: widget.laundry.id,
                                        deliveryId: widget.delivery.id,
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

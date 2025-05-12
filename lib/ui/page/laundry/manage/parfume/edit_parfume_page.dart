part of '../../../page.dart';

class EditParfumePage extends StatefulWidget {
  const EditParfumePage(
      {super.key, required this.laundry, required this.parfume});

  final Laundry laundry;
  final Parfume parfume;

  @override
  State<EditParfumePage> createState() => _EditParfumePageState();
}

class _EditParfumePageState extends State<EditParfumePage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    nameController.text = widget.parfume.name;
    priceController.text = widget.parfume.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Edit Parfume",
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
              icon: Icons.person,
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
              hintText: "Price",
              icon: Icons.monetization_on_rounded,
              validator: (value) {
                return numberValidator(value, "Price");
              },
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            BlocConsumer<ParfumeCubit, ParfumeState>(
              listener: (context, state) {
                if (state is ParfumeLoaded) {
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
                                      .read<ParfumeCubit>()
                                      .editParfume(
                                        name: nameController.text,
                                        price: int.parse(priceController.text),
                                        parfumeId: widget.parfume.id,
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

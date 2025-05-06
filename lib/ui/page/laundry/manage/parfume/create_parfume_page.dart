part of '../../../page.dart';

class CreateParfumePage extends StatefulWidget {
  const CreateParfumePage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<CreateParfumePage> createState() => _CreateParfumePageState();
}

class _CreateParfumePageState extends State<CreateParfumePage> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Create Parfume",
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
              icon: Icons.person,
              validator: (value) {
                return requiredValidator(value, "Name");
              },
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            InputField(
              controller: priceController,
              hintText: "Price",
              icon: Icons.monetization_on_rounded,
              validator: (value) {
                return numberValidator(value, "Price");
              },
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
                                      .read<ParfumeCubit>()
                                      .addParfume(
                                          name: nameController.text,
                                          price: int.parse(priceController.text),
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
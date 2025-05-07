part of '../../../page.dart';

class CreateLayananPage extends StatefulWidget {
  const CreateLayananPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<CreateLayananPage> createState() => _CreateLayananPageState();
}

class _CreateLayananPageState extends State<CreateLayananPage> {
  final nameController = TextEditingController();
  final durationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Create Layanan",
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
              icon: Icons.local_laundry_service_outlined,
              validator: (value) {
                return requiredValidator(value, "Name");
              },
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            InputField(
              label: "Duration",
              controller: durationController,
              hintText: "Duration",
              icon: Icons.timer,
              validator: (value) {
                return numberValidator(value, "Duration");
              },
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            BlocConsumer<LayananCubit, LayananState>(
              listener: (context, state) {
                if (state is LayananLoaded) {
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
                                      .read<LayananCubit>()
                                      .addLayanan(
                                          name: nameController.text,
                                          duration: int.parse(durationController.text),
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
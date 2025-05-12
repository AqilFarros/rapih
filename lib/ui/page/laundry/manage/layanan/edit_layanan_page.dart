part of '../../../page.dart';

class EditLayananPage extends StatefulWidget {
  const EditLayananPage(
      {super.key, required this.laundry, required this.layanan});

  final Laundry laundry;
  final Layanan layanan;

  @override
  State<EditLayananPage> createState() => _EditLayananPageState();
}

class _EditLayananPageState extends State<EditLayananPage> {
  final nameController = TextEditingController();
  final durationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    nameController.text = widget.layanan.name;
    durationController.text = widget.layanan.duration.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Edit Layanan",
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
              textInputAction: TextInputAction.done,
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
                                      .read<LayananCubit>()
                                      .editLayanan(
                                        name: nameController.text,
                                        duration:
                                            int.parse(durationController.text),
                                        layananId: widget.layanan.id,
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

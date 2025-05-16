part of '../../page.dart';

class AbsentPage extends StatefulWidget {
  const AbsentPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<AbsentPage> createState() => _AbsentPageState();
}

class _AbsentPageState extends State<AbsentPage> {
  final nameController = TextEditingController();
  final reasonController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> status = ['izin', 'sakit'];
  String? selectedValue;
  bool isLoading = false;

  Future<void> selectDate({required TextEditingController controller}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (picked != null) {
      controller.text = DateFormat("dd-MM-yyyy").format(picked);
    }
  }

  @override
  void initState() {
    fromController.text = DateFormat("dd-MM-yyyy").format(DateTime.now());
    toController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    selectedValue = status[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Absent",
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: defaultMargin),
                InputField(
                  label: "Permittor name",
                  controller: nameController,
                  hintText: "Name",
                  icon: Icons.person,
                  validator: (value) =>
                      requiredValidator(value, "Permittor name"),
                ),
                const SizedBox(height: defaultMargin),
                DropdownWidget<String, String>(
                  label: "Status",
                  selectedValue: selectedValue,
                  items: status,
                  getLabel: (item) => item,
                  getValue: (item) => item,
                  onChanged: (item) {
                    setState(() {
                      selectedValue = item;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a status" : null,
                  icon: Icons.info_outline_rounded,
                ),
                const SizedBox(height: defaultMargin),
                InputField(
                  label: "Reason",
                  controller: reasonController,
                  hintText: "",
                  icon: Icons.description_outlined,
                  validator: (value) => requiredValidator(value, "Reason"),
                  maxLines: 5,
                ),
                const SizedBox(height: defaultMargin),
                InputField(
                  onTap: () {
                    selectDate(controller: fromController);
                  },
                  label: "Start absent",
                  controller: fromController,
                  hintText: "Start absent",
                  icon: Icons.date_range,
                  validator: (value) =>
                      requiredValidator(value, "Start absent"),
                ),
                const SizedBox(height: defaultMargin),
                InputField(
                  onTap: () {
                    selectDate(controller: toController);
                  },
                  label: "End absent",
                  controller: toController,
                  hintText: "End absent",
                  icon: Icons.date_range,
                  validator: (value) => requiredValidator(value, "End absent"),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: defaultMargin),
                isLoading
                    ? CircularProgressIndicator(
                        color: mainColor,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SecondaryButton(
                            name: "Cancel",
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: defaultMargin),
                          PrimaryButton(
                            name: "Submit",
                            function: () async {
                              if (formKey.currentState!.validate() &&
                                  !isLoading) {
                                setState(() {
                                  isLoading = true;
                                });

                                var result =
                                    await AbsenceService().cashierAbsent(
                                  storeId: widget.laundry.id,
                                  status: selectedValue!,
                                  name: nameController.text,
                                  reason: reasonController.text,
                                  fromDate: fromController.text,
                                  toDate: toController.text,
                                );

                                if (result.value == true) {
                                  context.read<UserCubit>().setAbsent(true);
                                  Navigator.pop(context);
                                } else {
                                  print(result.message);
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

part of '../../page.dart';

class CreateLaundryPage extends StatefulWidget {
  const CreateLaundryPage({super.key});

  @override
  State<CreateLaundryPage> createState() => _CreateLaundryPageState();
}

class _CreateLaundryPageState extends State<CreateLaundryPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Laundry",
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: defaultMargin,
                ),
                InputField(
                  controller: nameController,
                  hintText: "Name",
                  icon: Icons.add_business_outlined,
                  validator: (String? value) {
                    return requiredValidator(value, "Name");
                  },
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                InputField(
                  controller: addressController,
                  hintText: "Address",
                  icon: Icons.location_on_outlined,
                  validator: (String? value) {
                    return requiredValidator(value, "Address");
                  },
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                InputField(
                  controller: contactNumberController,
                  hintText: "Contact Number",
                  icon: Icons.phone_outlined,
                  validator: (String? value) {
                    return requiredValidator(value, "Contact number");
                  },
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                InputField(
                  controller: descriptionController,
                  hintText: "",
                  icon: Icons.description_outlined,
                  validator: (String? value) {},
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    name: "Next",
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PictureLaundryPage(
                              name: nameController.text,
                              address: addressController.text,
                              contactNumber: contactNumberController.text,
                              description: descriptionController.text,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: SecondaryButton(
                    name: "Cancel",
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

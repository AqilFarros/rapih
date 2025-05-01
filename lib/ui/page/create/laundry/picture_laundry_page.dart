part of '../../page.dart';

class PictureLaundryPage extends StatefulWidget {
  const PictureLaundryPage({
    super.key,
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.description,
  });

  final String name;
  final String address;
  final String contactNumber;
  final String description;

  @override
  State<PictureLaundryPage> createState() => _PictureLaundryPageState();
}

class _PictureLaundryPageState extends State<PictureLaundryPage> {
  final _formKey = GlobalKey<FormState>();

  File? picture;
  File? logo;
  File? qris;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "A Little More",
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
                GestureDetector(
                  onTap: () async {
                    XFile? file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
          
                    if (file != null) {
                      setState(() {
                        picture = File(file.path);
                      });
                    }
                  },
                  child: ImageField(
                    image: picture,
                    title: "Picture",
                  ),
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                GestureDetector(
                  onTap: () async {
                    XFile? file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
          
                    if (file != null) {
                      setState(() {
                        logo = File(file.path);
                      });
                    }
                  },
                  child: ImageField(
                    image: logo,
                    title: "Logo (optional)",
                    width: 150,
                    radius: 99,
                  ),
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                GestureDetector(
                  onTap: () async {
                    XFile? file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
          
                    if (file != null) {
                      setState(() {
                        qris = File(file.path);
                      });
                    }
                  },
                  child: ImageField(
                    image: qris,
                    title: "Qris (optional)",
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: defaultMargin,
                ),
                BlocConsumer<LaundryCubit, LaundryState>(
                  listener: (context, state) {
                    if (state is LaundryLoaded) {
                      final role =
                          ((context.read<UserCubit>()).state as UserLoaded)
                              .user
                              .role;
                      String navigation = "";
          
                      if (role == "owner" || role == "admin") {
                        navigation = '/owner';
                      } else if (role == 'cashier') {
                        navigation = '/cashier';
                      } else {
                        navigation = '/unpaid';
                      }
                      Navigator.pushNamedAndRemoveUntil(
                          context, navigation, (route) => false);
                    } else if (state is LaundryLoadedFailed) {
                      print(state.message);
                    }
                  },
                  builder: (context, state) {
                    return isLoading
                        ? CircularProgressIndicator(
                            color: mainColor,
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: PrimaryButton(
                              name: "Create laundry",
                              function: () async {
                                Map<String, dynamic> data = {
                                  "name": widget.name,
                                  "address": widget.address,
                                  "contact_number": widget.contactNumber,
                                  "description": widget.description,
                                };
                                setState(() {
                                  isLoading = true;
                                });
                                await context.read<LaundryCubit>().createLaundry(
                                      data: data,
                                      image: picture!,
                                      logo: logo,
                                      qris: qris,
                                    );
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          );
                  },
                ),
                const SizedBox(
                  height: defaultMargin / 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SecondaryButton(
                    name: "Back",
                    function: () {
                      if (isLoading == false) {
                        Navigator.pop(context);
                      }
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

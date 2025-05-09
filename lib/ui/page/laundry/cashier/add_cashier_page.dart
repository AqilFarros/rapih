part of '../../page.dart';

class AddCashierPage extends StatefulWidget {
  const AddCashierPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<AddCashierPage> createState() => _AddCashierPageState();
}

class _AddCashierPageState extends State<AddCashierPage> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Add Cashier",
      widget: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: defaultMargin,
            ),
            InputField(
              label: "Email",
              controller: emailController,
              hintText: "Email",
              icon: Icons.email,
              validator: emailValidator,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            BlocConsumer<CashierCubit, CashierState>(
              listener: (context, state) {
                if (state is CashierLoaded) {
                  Navigator.pop(context);
                } else {
                  
                }
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
                            name: "Add",
                            function: () async {
                              if (isLoading) {
                                return;
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  await context.read<CashierCubit>().addCashier(
                                        email: emailController.text,
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

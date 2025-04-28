part of '../page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: defaultMargin * 2,
            ),
            InputField(
              controller: nameController,
              hintText: "Your Name",
              icon: CupertinoIcons.person,
              validator: nameValidator,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            InputField(
              controller: emailController,
              hintText: "Your Email",
              icon: CupertinoIcons.mail,
              validator: emailValidator,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            InputField(
              controller: passwordController,
              hintText: "Your Password",
              icon: CupertinoIcons.lock,
              isPassword: true,
              validator: passwordValidator,
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            InputField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              icon: CupertinoIcons.lock,
              isPassword: true,
              validator: (String? value) {
                return confirmPasswordValidator(value, passwordController);
              },
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserLoaded) {
                  if (state.user.role != "unpaid") {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    Navigator.pushReplacementNamed(context, '/subscribe');
                  }
                } else if (state is UserLoadedFailed) {
                  print(state.message);
                }
              },
              builder: (context, state) {
                return isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          name: "Sign Up",
                          function: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              await context.read<UserCubit>().signUp(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text);

                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                      );
              },
            ),
            const SizedBox(
              height: defaultMargin * 2,
            ),
            Text(
              "or sign up with",
              style: light,
            ),
            const SizedBox(
              height: defaultMargin * 2,
            ),
            SecondaryButton(
              name: "Sign Up With Google",
              icon: "asset/icon/google.png",
              function: () {},
            ),
            const SizedBox(
              height: defaultMargin / 2,
            ),
            SecondaryButton(
              name: "Sign Up With Apple",
              icon: "asset/icon/apple.png",
              function: () {},
            ),
            const SizedBox(
              height: defaultMargin * 2,
            ),
          ],
        ),
      ),
    );
  }
}

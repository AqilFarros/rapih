part of '../page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserLoaded) {
                  Navigator.pushReplacementNamed(context, roleNavigation(context));
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
                          name: "Sign In",
                          function: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              await context.read<UserCubit>().signIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );

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
              "or sign in with",
              style: light,
            ),
            const SizedBox(
              height: defaultMargin * 2,
            ),
            SecondaryButton(
              name: "Sign In With Google",
              icon: "asset/icon/google.png",
              function: () {},
            ),
            const SizedBox(
              height: defaultMargin / 2,
            ),
            SecondaryButton(
              name: "Sign In With Apple",
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

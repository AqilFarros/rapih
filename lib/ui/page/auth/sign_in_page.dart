part of '../page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              name: "Sign In",
              function: () {},
            ),
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
    );
  }
}

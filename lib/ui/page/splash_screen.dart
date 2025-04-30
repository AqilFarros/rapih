part of 'page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalToken;
  String? navigation;

  Future getValidationData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    setState(() {
      finalToken = token;
    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      if (finalToken != null && mounted) {
        await context.read<UserCubit>().getUserByToken(token: finalToken!);
        if (User.token != null && mounted) {
          final role =
              ((context.read<UserCubit>()).state as UserLoaded).user.role;

          if (role == "owner" || role == "admin") {
            setState(() {
              navigation = '/owner';
            });
          } else if (role == 'cashier') {
            setState(() {
              navigation = '/cashier';
            });
          } else {
            setState(() {
              navigation = '/unpaid';
            });
          }
        }
      }
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(
            context, navigation == null ? '/boarding' : navigation!),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/image/logo.png',
              width: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rapih",
              style: bold.copyWith(
                fontSize: heading1,
                color: mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

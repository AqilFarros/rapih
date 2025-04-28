part of 'page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalToken;

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
      }
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(
            context, finalToken == null ? '/boarding' : '/home'),
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

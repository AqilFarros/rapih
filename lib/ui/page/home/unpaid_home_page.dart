part of '../page.dart';

class UnpaidHomePage extends StatelessWidget {
  const UnpaidHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: grayColor.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/image/uang.png',
              width: 300,
            ),
            const SizedBox(
              height: 70,
            ),
            Text(
              "Please subscribe to continue",
              style: semiBold.copyWith(
                fontSize: heading1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
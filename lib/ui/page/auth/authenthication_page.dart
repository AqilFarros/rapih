part of '../page.dart';

class AuthenthicationPage extends StatelessWidget {
  const AuthenthicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: defaultMargin * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("asset/image/logo.png", height: 30),
                  Text(
                    " Rapih",
                    style: bold.copyWith(
                      fontSize: heading1,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultMargin * 3,
              ),
              Text(
                "Welcome to Rapih",
                style: regular.copyWith(fontSize: heading1),
              ),
              const SizedBox(
                height: defaultMargin / 2,
              ),
              Text(
                "Sign up or sign in to manage your laundry with rapih",
                style: medium.copyWith(
                  fontSize: description,
                  color: grayColor,
                ),
              ),
              const SizedBox(
                height: defaultMargin * 3,
              ),
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: mainColor,
                labelColor: mainColor,
                labelStyle: medium.copyWith(color: grayColor),
                tabs: const [
                  Tab(
                    child: Text("Sign in"),
                  ),
                  Tab(
                    child: Text("Sign up"),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      color: grayColor.withOpacity(0.1),
                      child: const SignInPage(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      color: grayColor.withOpacity(0.1),
                      child: const SignUpPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

part of 'page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _selectedIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
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
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                itemCount: ongoingData.length,
                itemBuilder: (context, index) {
                  return OnBoardingContent(
                    illustration: ongoingData[index]["illustration"],
                    title: ongoingData[index]["title"],
                    text: ongoingData[index]["description"],
                  );
                },
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                ongoingData.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultMargin / 2),
                  child: AnimatedDot(isActive: _selectedIndex == index),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
              width: double.infinity,
              child: PrimaryButton(
                name: _selectedIndex == ongoingData.length - 1
                    ? "Get Started"
                    : "Next",
                function: () async {
                  if (_selectedIndex < ongoingData.length - 1) {
                    await _pageController.animateToPage(
                      _selectedIndex + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthenthicationPage(),
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
              width: double.infinity,
              child: SecondaryButton(
                name:
                    _selectedIndex == ongoingData.length - 1 ? "Back" : "Skip",
                function: () async {
                  if (_selectedIndex != ongoingData.length - 1) {
                    await _pageController.animateToPage(
                      ongoingData.length - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    await _pageController.animateToPage(
                      _selectedIndex - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class AnimatedDot extends StatelessWidget {
  const AnimatedDot({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 20 : 6,
      decoration: BoxDecoration(
        color: isActive ? mainColor : grayColor,
        borderRadius: BorderRadius.circular(defaultMargin),
      ),
    );
  }
}

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.illustration,
    required this.title,
    required this.text,
  });

  final String illustration, title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: SvgPicture.asset(illustration),
          ),
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        Text(
          title,
          style: bold.copyWith(fontSize: heading1),
        ),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        Text(
          text,
          style: medium.copyWith(
            color: grayColor,
            fontSize: description,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> ongoingData = [
  {
    "illustration": "asset/image/image1.svg",
    "title": "Manage your laundry",
    "description":
        "We offer platform to manage your laundry\nfrom anywhere with your smartphone\nthought our app."
  },
  {
    "illustration": "asset/image/image2.svg",
    "title": "Organize laudry orders",
    "description":
        "We offer platform to manage your laundry\nfrom anywhere with your smartphone\nthought our app."
  },
  {
    "illustration": "asset/image/image3.svg",
    "title": "Monitor financial stats",
    "description":
        "We offer platform to manage your laundry\nfrom anywhere with your smartphone\nthought our app."
  }
];

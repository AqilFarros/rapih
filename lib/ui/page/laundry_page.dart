part of 'page.dart';

class LaundryPage extends StatefulWidget {
  const LaundryPage({super.key});

  @override
  State<LaundryPage> createState() => _LaundryPageState();
}

class _LaundryPageState extends State<LaundryPage> {
  int _selectedIndex = 0;
  final _pageController = PageController();

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
          children: [
            const SizedBox(
              height: defaultMargin * 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to",
                      style: medium.copyWith(
                        fontSize: heading1,
                      ),
                    ),
                    Text(
                      "Laundry pak Ujang",
                      style: medium.copyWith(
                        fontSize: heading1,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 90,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPzjFyJ39NLJEFydPkuOF-WyJvzRzbZ1915A&s',
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(defaultMargin),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            Row(
              children: List.generate(
                laundryWidget.length,
                (index) => GestureDetector(
                  onTap: () async {
                    await _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: LaundryNavigation(
                    text: laundryWidget[index]["text"],
                    icon: laundryWidget[index]["icon"],
                    isActive: _selectedIndex == index,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            Expanded(
              child: PageView.builder(
                itemCount: laundryWidget.length,
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                itemBuilder: (BuildContext context, int index) =>
                    laundryWidget[_selectedIndex]["widget"],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LaundryNavigation extends StatelessWidget {
  const LaundryNavigation({
    super.key,
    required this.text,
    required this.icon,
    required this.isActive,
  });

  final String text;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: defaultMargin),
      padding: EdgeInsets.symmetric(
        vertical: defaultMargin / 3,
        horizontal: isActive ? defaultMargin : 0,
      ),
      decoration: BoxDecoration(
        color: isActive ? mainColor : Colors.transparent,
        borderRadius: BorderRadius.circular(defaultMargin),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isActive ? whiteColor : blackColor,
          ),
          const SizedBox(
            width: defaultMargin / 2,
          ),
          Text(
            text,
            style: regular.copyWith(color: isActive ? whiteColor : blackColor),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> laundryWidget = [
  {
    "icon": Icons.shopping_cart,
    "text": "Home",
    "widget": const MainPage(),
  },
  {
    "icon": Icons.payments_rounded,
    "text": "Finance",
    "widget": const FinancePage(),
  },
  {
    "icon": Icons.edit,
    "text": "Edit",
    "widget": const EditLaundry(),
  },
];

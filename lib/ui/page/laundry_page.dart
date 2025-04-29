part of 'page.dart';

class LaundryPage extends StatefulWidget {
  const LaundryPage({super.key});

  @override
  State<LaundryPage> createState() => _LaundryPageState();
}

class _LaundryPageState extends State<LaundryPage> {
  final _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: whiteColor,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              itemCount: laundryWidget.length,
              itemBuilder: (BuildContext context, int index) => LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const LaundryHeader(),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(defaultMargin),
                                decoration: BoxDecoration(
                                  color: grayColor.withOpacity(0.1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      offset: Offset(0, -2),
                                      blurRadius: 24,
                                      spreadRadius: 2,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.6),
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(defaultMargin * 2),
                                    topRight:
                                        Radius.circular(defaultMargin * 2),
                                  ),
                                ),
                                child: laundryWidget[index]["widget"],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(defaultMargin * 2),
              ),
              padding: const EdgeInsets.all(defaultMargin / 2),
              margin: const EdgeInsets.fromLTRB(
                  defaultMargin, 0, defaultMargin, defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ),
          ),
        ],
      ),
    );
  }
}

class LaundryHeader extends StatelessWidget {
  const LaundryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: defaultMargin * 3,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to",
                    style: semiBold.copyWith(
                      fontSize: heading2,
                    ),
                  ),
                  Text(
                    "Laundry pak Ujang",
                    style: semiBold.copyWith(
                      fontSize: heading2,
                    ),
                  ),
                  Text(
                    "Name: Anto Bambang Santoso",
                    style: regular.copyWith(
                      fontSize: description,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
        ],
      ),
    );
  }
}

class LaundryNavigation extends StatelessWidget {
  const LaundryNavigation({
    super.key,
    required this.icon,
    required this.text,
    required this.isActive,
  });

  final IconData icon;
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: defaultMargin),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultMargin / 2,
        vertical: defaultMargin / 4,
      ),
      decoration: BoxDecoration(
        color: isActive ? whiteColor : Colors.transparent,
        borderRadius: BorderRadius.circular(defaultMargin),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isActive ? mainColor : whiteColor,
          ),
          SizedBox(
            width: isActive ? defaultMargin / 3 : 0,
          ),
          Text(
            isActive ? text : "",
            style: medium.copyWith(
              color: isActive ? mainColor : whiteColor,
              fontSize: description,
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> laundryWidget = [
  {
    "icon": Icons.home_rounded,
    "text": "Home",
    "widget": const MainPage(),
  },
  {
    "icon": Icons.business_center_outlined,
    "text": "Manage",
    "widget": const ManageLaundryPage(),
  },
  {
    "icon": Icons.history,
    "text": "Order",
    "widget": const TransactionPage(),
  },
  {
    "icon": Icons.person,
    "text": "Absent",
    "widget": const AbsentPage(),
  },
];

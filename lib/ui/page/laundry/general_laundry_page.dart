// ignore_for_file: deprecated_member_use

part of '../page.dart';

class GeneralLaundryPage extends StatefulWidget {
  const GeneralLaundryPage({
    super.key,
    required this.laundry,
  });

  final Laundry laundry;

  @override
  State<GeneralLaundryPage> createState() => _GeneralLaundryPageState();
}

class _GeneralLaundryPageState extends State<GeneralLaundryPage> {
  final _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> laundryWidget = getLaundryWidget(widget.laundry);

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
                            LaundryHeader(laundry: widget.laundry),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(defaultMargin),
                                decoration: BoxDecoration(
                                  color: grayColor.withOpacity(0.1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      offset: const Offset(0, -2),
                                      blurRadius: 24,
                                      spreadRadius: 2,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.6),
                                      offset: const Offset(0, 2),
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
  const LaundryHeader({
    super.key,
    required this.laundry,
  });

  final Laundry laundry;

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
                    laundry.name,
                    style: semiBold.copyWith(
                      fontSize: heading2,
                    ),
                  ),
                  Text(
                    "Name: ${(context.read<UserCubit>().state as UserLoaded).user.username}",
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
                      '$imageUrl/${laundry.picture}',
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
            size: heading,
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

List<Map<String, dynamic>> getLaundryWidget(Laundry laundry) => [
      {
        "icon": Icons.home_rounded,
        "text": "Home",
        "widget": MainPage(laundry: laundry),
      },
      {
        "icon": Icons.history,
        "text": "Order",
        "widget": TransactionPage(laundry: laundry),
      },
      {
        "icon": Icons.person,
        "text": "Absent",
        "widget": AbsencePage(laundry: laundry),
      },
      {
        // "icon": Icons.business_center_outlined,
        "icon": Icons.settings,
        "text": "Manage",
        "widget": ManageLaundryPage(laundry: laundry),
      },
    ];

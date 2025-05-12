part of 'page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Welcome back",
                        style: medium.copyWith(
                          fontSize: heading1,
                        ),
                      ),
                      Text(
                        ((context.read<UserCubit>().state) as UserLoaded)
                            .user
                            .username,
                        style: medium.copyWith(
                          fontSize: heading1,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
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
              CardWidget(
                content: Row(
                  children: [
                    Text(
                      "Add a new laundry",
                      style: regular.copyWith(fontSize: heading2),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.add_business_outlined,
                      size: heading1,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              const TitleSection(text: "Current laundry"),
              const SizedBox(
                height: defaultMargin,
              ),
              // LaundryCard(),
              // const SizedBox(
              //   height: defaultMargin,
              // ),
              // LaundryCard(),
              // const SizedBox(
              //   height: defaultMargin,
              // ),
              // LaundryCard(),
              // const SizedBox(
              //   height: defaultMargin,
              // ),
              // LaundryCard(),
              // const SizedBox(
              //   height: defaultMargin,
              // ),
              // LaundryCard(),
            ],
          ),
        ),
      ),
    );
  }
}

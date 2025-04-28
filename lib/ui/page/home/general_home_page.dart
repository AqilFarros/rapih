part of '../page.dart';

class GeneralHomePage extends StatelessWidget {
  const GeneralHomePage({super.key, required this.widget,});

  final Widget widget;

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
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
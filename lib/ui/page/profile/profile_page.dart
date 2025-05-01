part of '../page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final state = context.read<UserCubit>().state;

    if (state is UserLoaded) {
      user = state.user;
    } else {
      user = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: semiBold.copyWith(fontSize: heading2),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: defaultMargin * 2),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png',
                  ),
                ),
                const SizedBox(height: defaultMargin),
                Text(
                  user != null ? user!.username : 'Guest',
                  style: semiBold.copyWith(fontSize: heading2),
                ),
                Text(
                  user != null ? user!.role : 'Guest',
                  style:
                      semiBold.copyWith(fontSize: heading3, color: grayColor),
                ),
                const SizedBox(height: defaultMargin * 2),
                profileSection(
                  title: "Change Password",
                  iconData: Icons.lock_outline,
                  onTap: () {},
                ),
                profileSection(
                  title: "Logout",
                  iconData: Icons.logout_outlined,
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await context.read<UserCubit>().logout();
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushNamedAndRemoveUntil(
                        // ignore: use_build_context_synchronously
                        context,
                        '/auth',
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget profileSection({
  required String title,
  required IconData iconData,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap as VoidCallback?,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: defaultMargin),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: grayColor),
        ),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: mainColor,
            size: heading,
          ),
          const SizedBox(width: defaultMargin / 2),
          Text(
            title,
            style: medium.copyWith(fontSize: heading3),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    ),
  );
}

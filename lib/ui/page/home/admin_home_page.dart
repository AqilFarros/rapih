part of '../page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralHomePage(widget: Column(
      children: [
        const TitleSection(text: 'Current user'),
        const SizedBox(height: defaultMargin / 2,),
      ],
    ),);
  }
}
part of '../../page.dart';

class GeneralManagePage extends StatelessWidget {
  const GeneralManagePage(
      {super.key, required this.title, required this.widget,});

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: SingleChildScrollView(child: widget,),
      ),
    );
  }
}

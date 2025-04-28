part of '../widget.dart';

class ManageWidget extends StatelessWidget {
  const ManageWidget({
    super.key,
    required this.text,
    required this.image,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      content: Row(
        children: [
          Text(
            text,
            style: medium.copyWith(fontSize: heading2),
          ),
          const Spacer(),
          Image.asset(image, height: 40),
        ],
      ),
    );
  }
}

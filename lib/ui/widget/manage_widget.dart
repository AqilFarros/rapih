part of 'widget.dart';

class ManageWidget extends StatelessWidget {
  const ManageWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });

  final String text;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as Function(),
      child: CardWidget(
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
      ),
    );
  }
}

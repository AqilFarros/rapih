part of 'widget.dart';

class AddIllustrationWidget extends StatelessWidget {
  const AddIllustrationWidget({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  final String image;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap as void Function(),
        child: Column(
          children: [
            Image.asset(image, width: 100, height: 100),
            const SizedBox(
              height: defaultMargin,
            ),
            Text(
              "Please add $text to continue",
              style: medium.copyWith(
                fontSize: heading2,
              ),
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            PrimaryButton(
              name: "Add $text",
              function: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

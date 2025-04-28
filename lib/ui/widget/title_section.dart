part of 'widget.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: medium.copyWith(
        fontSize: heading2,
      ),
    );
  }
}

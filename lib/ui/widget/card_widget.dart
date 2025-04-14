part of 'widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          defaultMargin,
        ),
      ),
      child: content,
    );
  }
}

part of 'widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.content,
    this.color,
  });

  final Widget content;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? whiteColor,
        borderRadius: BorderRadius.circular(
          defaultMargin,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 2),
            blurRadius: 6,
          )
        ],
      ),
      child: content,
    );
  }
}

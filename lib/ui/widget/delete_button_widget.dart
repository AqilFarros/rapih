part of 'widget.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: defaultMargin / 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultMargin / 2),
          border: Border.all(color: mainColor),
          color: mainColor,
        ),
        child: Icon(
          Icons.delete,
          color: whiteColor,
          size: 22,
        ),
      ),
    );
  }
}

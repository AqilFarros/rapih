part of 'widget.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.name,
    required this.function,
  });
  final String name;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function as void Function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultMargin / 2),
        ),
      ),
      child: Text(
        name,
        style: semiBold.copyWith(
          fontSize: heading3,
          color: whiteColor,
        ),
      ),
    );
  }
}

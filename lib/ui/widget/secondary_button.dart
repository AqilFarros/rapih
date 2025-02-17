part of 'widget.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.name,
    required this.function,
    this.icon,
  });

  final String name;
  final String? icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function as void Function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: whiteSmokeColor),
          borderRadius: BorderRadius.circular(defaultMargin / 2),
        ),
      ),
      child: icon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon!,
                  height: 20,
                ),
                const SizedBox(
                  width: defaultMargin / 2,
                ),
                Text(
                  name,
                  style: semiBold.copyWith(
                    fontSize: heading3,
                    color: blackColor,
                  ),
                ),
              ],
            )
          : Text(
              name.toString(),
              style: semiBold.copyWith(
                fontSize: heading3,
                color: blackColor,
              ),
            ),
    );
  }
}

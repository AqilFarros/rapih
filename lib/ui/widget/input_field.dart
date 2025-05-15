part of 'widget.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.icon,
    this.isPassword,
    this.textInputAction,
    required this.validator,
    this.maxLines,
    this.onTap,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool? isPassword;
  final TextInputAction? textInputAction;
  final Function validator;
  final int? maxLines;
  final void Function()? onTap;
  final TextInputType? keyboardType;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: medium,
        ),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        TextFormField(
          onTap: widget.onTap,
          controller: widget.controller,
          readOnly: widget.onTap != null ? true : false,
          decoration: InputDecoration(
            filled: true,
            fillColor: whiteColor,
            prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
            suffixIcon: widget.isPassword == true
                ? isObscure == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: const Icon(CupertinoIcons.eye_fill),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: const Icon(CupertinoIcons.eye_slash_fill),
                      )
                : null,
            hintText: widget.hintText,
            hintStyle: light,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultMargin / 2),
              borderSide: BorderSide(color: whiteSmokeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultMargin / 2),
              borderSide: BorderSide(color: mainColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultMargin / 2),
              borderSide: BorderSide(color: redColor),
            ),
          ),
          cursorColor: mainColor,
          cursorErrorColor: redColor,
          obscureText: widget.isPassword == true ? isObscure : false,
          style: regular,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          validator: widget.validator as String? Function(String?)?,
          maxLines: widget.maxLines ?? 1,
        ),
      ],
    );
  }
}

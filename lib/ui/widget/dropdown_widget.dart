part of 'widget.dart';

class DropdownWidget<T, D> extends StatelessWidget {
  const DropdownWidget({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.items,
    required this.getLabel,
    required this.getValue,
    required this.onChanged,
    required this.validator,
    this.icon,
  });

  final String label;
  final T? selectedValue;
  final List<D> items;
  final String Function(D item) getLabel;
  final dynamic Function(D item) getValue;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: medium,
        ),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        DropdownButtonFormField(
          value: selectedValue,
          isExpanded: true,
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: getValue(item),
                  child: Text(
                    getLabel(item),
                    style: regular.copyWith(color: blackColor),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: whiteColor,
            prefixIcon: icon != null ? Icon(icon) : null,
            hintText: "Select an item",
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
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          dropdownColor: whiteColor,
          style: regular,
          validator: validator,
        ),
      ],
    );
  }
}

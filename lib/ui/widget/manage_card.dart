part of 'widget.dart';

class ManageCard<T> extends StatelessWidget {
  const ManageCard({
    super.key,
    required this.title,
    required this.image,
    this.widget,
    this.edit,
    this.delete,
    this.isOrder = false,
    this.data,
  });

  final String title;
  final String image;
  final List<Widget>? widget;
  final void Function()? edit;
  final void Function()? delete;
  final bool? isOrder;
  final T? data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isOrder == true) {
          Navigator.pop(context, data);
        }
      },
      child: CardWidget(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            const SizedBox(height: defaultMargin / 2),
            Text(
              title,
              style: semiBold.copyWith(fontSize: heading2),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            ...widget ?? [],
            const SizedBox(height: defaultMargin / 2),
            edit != null || delete != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      EditButtonWidget(onTap: edit!),
                      const SizedBox(
                        width: defaultMargin / 2,
                      ),
                      DeleteButtonWidget(onTap: delete!),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

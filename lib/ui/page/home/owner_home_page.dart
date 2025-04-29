part of '../page.dart';

class OwnerHomePage extends StatelessWidget {
  const OwnerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralHomePage(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/create-laundry');
            },
            child: CardWidget(
              content: Row(
                children: [
                  Text(
                    "Add a new laundry",
                    style: regular.copyWith(fontSize: heading2),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.add_business_outlined,
                    size: heading1,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          const TitleSection(text: 'Current laundry'),
          const SizedBox(
            height: defaultMargin / 2,
          ),
        ],
      ),
    );
  }
}

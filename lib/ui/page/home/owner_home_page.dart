part of '../page.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({super.key});

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  @override
  void initState() {
    context.read<LaundryCubit>().getLaundry();
    super.initState();
  }

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
          BlocBuilder<LaundryCubit, LaundryState>(
            builder: (context, state) {
              if (state is LaundryLoaded) {
                if (state.laundry.isEmpty) {
                  return Center(
                    child: Text('No laundry data available'),
                  );
                } else {
                  return Column(
                    children: state.laundry
                        .map((e) => [
                              LaundryCard(
                                laundry: e,
                              ),
                              const SizedBox(height: defaultMargin),
                            ])
                        .expand((pair) => pair)
                        .toList()
                      ..removeLast(),
                  );
                }
              } else if (state is LaundryLoadedFailed) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: defaultMargin,
          ),
        ],
      ),
    );
  }
}

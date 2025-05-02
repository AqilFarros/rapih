part of '../../../page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    context.read<CategoryCubit>().getCategory(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Catagory",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultMargin),
          ManageWidget(
            onTap: () {},
            text: "Add a new category",
            image: "asset/icon/category.png",
          ),
          const SizedBox(height: defaultMargin),
          const TitleSection(text: "Current Category"),
          const SizedBox(
            height: defaultMargin / 2,
          ),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoaded) {
                return Wrap(
                  spacing: defaultMargin,
                  runSpacing: defaultMargin,
                  children: List.generate(
                    state.category.length,
                    (index) => SizedBox(
                      width: MediaQuery.of(context).size.width / 2 -
                          (defaultMargin + 8),
                      child: CardWidget(
                        content: Column(
                          children: [
                            Image.asset("asset/icon/category.png"),
                            const SizedBox(height: defaultMargin / 2),
                            Text(
                              state.category[index].name,
                              style: medium.copyWith(fontSize: heading1),
                            ),
                            const SizedBox(height: defaultMargin / 2),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: SecondaryButton(
                                name: "Edit",
                                function: () {},
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: PrimaryButton(
                                name: "Delete",
                                function: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is CategoryLoadedFailed) {
                return Text(state.message);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

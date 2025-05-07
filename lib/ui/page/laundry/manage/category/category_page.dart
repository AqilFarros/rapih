part of '../../../page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<CategoryCubit>().getCategory(storeId: widget.laundry.id);
    context.read<ProductCubit>().getProduct(storeId: widget.laundry.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralManagePage(
      title: "Category",
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultMargin),
          ManageWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateCategoryPage(
                    laundry: widget.laundry,
                  ),
                ),
              );
            },
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
                if (state.category.isEmpty) {
                  return AddIllustrationWidget(
                    image: 'asset/icon/category.png',
                    text: "a category",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateCategoryPage(
                            laundry: widget.laundry,
                          ),
                        ),
                      );
                    },
                  );
                }
                return isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      )
                    : LayoutBuilder(builder: (context, constraints) {
                        double itemWidth =
                            (constraints.maxWidth - defaultMargin) / 2;
                        return Wrap(
                          spacing: defaultMargin,
                          runSpacing: defaultMargin,
                          children: List.generate(
                            state.category.length,
                            (index) => SizedBox(
                              width: itemWidth,
                              child: ManageCard(
                                title: state.category[index].name,
                                image: "asset/icon/category.png",
                                edit: () {
                                  if (!isLoading) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditCategoryPage(
                                          laundry: widget.laundry,
                                          category: state.category[index],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                delete: () async {
                                  if (!isLoading) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    await context
                                        .read<CategoryCubit>()
                                        .deleteCategory(
                                            storeId: widget.laundry.id,
                                            categoryId:
                                                state.category[index].id);

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      });
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

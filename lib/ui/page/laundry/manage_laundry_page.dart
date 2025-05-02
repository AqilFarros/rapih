part of '../page.dart';

class ManageLaundryPage extends StatelessWidget {
  const ManageLaundryPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ManageWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPage(laundry: laundry),
              ),
            );
          },
          text: "Add a new category",
          image: "asset/icon/category.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {},
          text: "Add a new product",
          image: "asset/icon/laundry-machine.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {},
          text: "Add a new customer",
          image: "asset/icon/customer.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {},
          text: "Add a new delivery",
          image: "asset/icon/delivery.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {},
          text: "Add a new parfume",
          image: "asset/icon/parfume.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {},
          text: "Add a new discounted service",
          image: "asset/icon/discount.png",
        ),
      ],
    );
  }
}

part of '../page.dart';

class ManageLaundryPage extends StatelessWidget {
  const ManageLaundryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ManageWidget(
          text: "Add a new category",
          image: "asset/icon/category.png",
        ),
        SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          text: "Add a new product",
          image: "asset/icon/laundry-machine.png",
        ),
        SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          text: "Add a new customer",
          image: "asset/icon/customer.png",
        ),
        SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          text: "Add a new delivery",
          image: "asset/icon/delivery.png",
        ),
        SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          text: "Add a new parfume",
          image: "asset/icon/parfume.png",
        ),
        SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          text: "Add a new discounted service",
          image: "asset/icon/discount.png",
        ),
      ],
    );
  }
}

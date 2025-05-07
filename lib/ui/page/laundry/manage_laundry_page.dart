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
          text: "Manage laundry",
          image: "asset/icon/laundry.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPage(laundry: laundry),
              ),
            );
          },
          text: "Manage category",
          image: "asset/icon/category.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(laundry: laundry),
              ),
            );
          },
          text: "Manage product",
          image: "asset/icon/laundry-machine.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LayananPage(laundry: laundry),
              ),
            );
          },
          text: "Manage layanan",
          image: "asset/icon/layanan.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerPage(laundry: laundry),
              ),
            );
          },
          text: "Manage customer",
          image: "asset/icon/customer.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeliveryPage(laundry: laundry),
              ),
            );
          },
          text: "Manage delivery",
          image: "asset/icon/delivery.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParfumePage(laundry: laundry),
              ),
            );
          },
          text: "Manage parfume",
          image: "asset/icon/parfume.png",
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        ManageWidget(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiscountPage(laundry: laundry),
              ),
            );
          },
          text: "Manage discounted service",
          image: "asset/icon/discount.png",
        ),
        const SizedBox(
          height: 70,
        ),
      ],
    );
  }
}

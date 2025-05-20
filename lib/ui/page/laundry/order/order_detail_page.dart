part of '../../page.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({
    super.key,
    required this.laundry,
    required this.order,
  });

  final Laundry laundry;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Order',
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardWidget(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Kode pesanan: ",
                          style: medium.copyWith(fontSize: heading2),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(defaultMargin / 2),
                            color: switch (order.status) {
                              "expired" => redColor,
                              "pending" => Colors.amber,
                              "bisa_diambil" => greenColor,
                              "dicuci" => secondaryColor,
                              "completed" => mainColor,
                              _ => grayColor,
                            },
                          ),
                          child: Text(
                            order.status == 'bisa_diambil'
                                ? "Bisa diambil"
                                : order.status,
                            style: medium.copyWith(
                              fontSize: heading3,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      order.orderCode,
                      style: semiBold.copyWith(
                        fontSize: heading1,
                        color: mainColor,
                      ),
                    ),
                    const SizedBox(height: defaultMargin),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: heading1,
                          color: mainColor,
                        ),
                        Text(
                          " ${order.customer.name}",
                          style: medium.copyWith(
                            fontSize: heading2,
                            color: grayColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultMargin / 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: heading1,
                          color: mainColor,
                        ),
                        Text(
                          " ${order.customer.address}",
                          style: medium.copyWith(
                            fontSize: heading2,
                            color: grayColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultMargin / 2),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: heading1,
                          color: mainColor,
                        ),
                        Text(
                          " ${order.customer.number}",
                          style: medium.copyWith(
                            fontSize: heading2,
                            color: grayColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultMargin),
                    Row(
                      children: [
                        Text(
                          "Metode pembayaran: ",
                          style: medium.copyWith(
                            fontSize: heading2,
                          ),
                        ),
                        Text(
                          order.paymentMethod,
                          style: medium.copyWith(
                            fontSize: heading2,
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultMargin / 2),
                    Row(
                      children: [
                        Text(
                          "Status pembayaran: ",
                          style: medium.copyWith(
                            fontSize: heading2,
                          ),
                        ),
                        Text(
                          order.isPaid ? "sudah dibayar" : "belum dibayar",
                          style: medium.copyWith(
                            fontSize: heading2,
                            color: order.isPaid ? greenColor : redColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultMargin / 2),
                    Text(
                      "Estismasi selesai:",
                      style: medium.copyWith(
                        fontSize: heading2,
                      ),
                    ),
                    Text(
                      DateFormat("EEEE, dd MMMM yyyy HH:mm", 'id_ID').format(
                        DateTime.parse(order.estDate),
                      ),
                      style: medium.copyWith(
                        fontSize: heading2,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: defaultMargin),
              CardWidget(content: Column(),),
            ],
          ),
        ),
      ),
    );
  }
}

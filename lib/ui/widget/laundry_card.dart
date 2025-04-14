part of 'widget.dart';

class LaundryCard extends StatelessWidget {
  const LaundryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/laundry');
      },
      child: CardWidget(
        content: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Laundry pak Ujang",
                      style: medium.copyWith(
                        fontSize: heading4,
                        color: blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "Babakan Madang, Sentul",
                      style: regular.copyWith(
                        fontSize: description,
                        color: grayColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
                Container(
                  width: 140,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPzjFyJ39NLJEFydPkuOF-WyJvzRzbZ1915A&s',
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(defaultMargin),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultMargin,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(1000000),
                          style: medium.copyWith(
                            fontSize: heading1,
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.person,
                      size: 32,
                      color: mainColor,
                    ),
                    Text(
                      "10",
                      style: medium.copyWith(
                        fontSize: heading1,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

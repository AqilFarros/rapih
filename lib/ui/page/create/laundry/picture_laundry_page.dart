part of '../../page.dart';

class PictureLaundryPage extends StatelessWidget {
  const PictureLaundryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "A Little More",
                style: semiBold.copyWith(fontSize: heading1),
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              ImageField(
                title: "Picture",
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              ImageField(
                title: "Logo (optional)",
                width: 150,
                radius: 99,
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              ImageField(
                title: "Qris (optional)",
                width: 150,
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  name: "Create laundry",
                  function: () {},
                ),
              ),
              const SizedBox(
                height: defaultMargin / 2,
              ),
              SizedBox(
                width: double.infinity,
                child: SecondaryButton(
                  name: "Back",
                  function: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

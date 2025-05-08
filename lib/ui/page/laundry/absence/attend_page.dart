part of '../../page.dart';

class AttendPage extends StatefulWidget {
  const AttendPage({super.key, required this.laundry});

  final Laundry laundry;

  @override
  State<AttendPage> createState() => _AttendPageState();
}

class _AttendPageState extends State<AttendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Attend",
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
              const SizedBox(height: defaultMargin),
              GestureDetector(
                onTap: () async {
                  await availableCameras().then(
                    (value) => Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraPage(
                          camera: value,
                        ),
                      ),
                    ),
                  );
                },
                child: ImageField(title: "Your photo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

part of '../../page.dart';

class AttendPage extends StatefulWidget {
  const AttendPage({super.key, required this.laundry, this.image});

  final Laundry laundry;
  final XFile? image;

  @override
  State<AttendPage> createState() => _AttendPageState();
}

class _AttendPageState extends State<AttendPage> {
  String? imageError;
  bool isLoading = false;

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
                  if (isLoading) return;
                  final cameras = await availableCameras();

                  final result = await Navigator.push<XFile?>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraPage(
                        laundry: widget.laundry,
                        camera: cameras,
                      ),
                    ),
                  );

                  if (result != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendPage(
                          laundry: widget.laundry,
                          image: result,
                        ),
                      ),
                    );
                  }
                },
                child: ImageField(
                  title: "Your photo",
                  image: widget.image != null ? File(widget.image!.path) : null,
                  width: 300,
                  height: 533,
                  errorMessage: imageError,
                ),
              ),
              const SizedBox(
                height: defaultMargin,
              ),
              isLoading
                  ? CircularProgressIndicator(
                      color: mainColor,
                    )
                  : PrimaryButton(
                      name: "Submit",
                      function: () async {
                        if (widget.image != null) {
                          setState(() {
                            isLoading = true;
                            imageError = null;
                          });

                          var result = await AbsenceService().cashierAttend(
                            storeId: widget.laundry.id,
                            image: File(widget.image!.path),
                          );

                          if (result.value == true) {
                            context.read<UserCubit>().setAbsent(true);
                            Navigator.pop(context);
                          } else {
                            print(result.message);
                          }

                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            imageError = "Your photo is required";
                          });
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

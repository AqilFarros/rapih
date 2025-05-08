part of '../../page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, this.camera});

  final List<CameraDescription>? camera;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initCamera(widget.camera![0]);
    super.initState();
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    try {
      await _cameraController.initialize();
      if (!mounted) return;
      setState(() {});
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Attend",
          style: semiBold.copyWith(fontSize: heading1),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _cameraController.value.isInitialized
            ? CameraPreview(_cameraController)
            : const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        )
      ),
    );
  }
}

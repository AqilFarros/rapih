part of 'widget.dart';

class ImageField extends StatefulWidget {
  const ImageField({
    super.key,
    required this.title,
    this.width,
    this.height,
    this.radius,
  });

  final String title;
  final double? width;
  final double? height;
  final double? radius;

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        XFile? file =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (file != null) {
          setState(() {
            image = File(file.path);
          });
        }
      },
      child: Column(
        children: [
          Text(
            widget.title,
            style: medium.copyWith(fontSize: heading2),
          ),
          const SizedBox(
            height: 10,
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(widget.radius ?? 10),
            dashPattern: const [10, 4],
            strokeWidth: 2,
            color: Colors.grey.shade500,
            child: Container(
              width: widget.width ?? double.infinity,
              height: widget.height ?? 150,
              padding: EdgeInsets.all(image != null ? 0 : defaultMargin / 2),
              margin: EdgeInsets.all(image != null ? defaultMargin / 2 : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius ?? 10),
                color: Colors.white,
                image: DecorationImage(
                  image: image != null
                      ? FileImage(image!)
                      : const AssetImage('asset/image/add.jpg'),
                  fit: image != null ? BoxFit.cover : BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

part of 'widget.dart';

class ImageField extends StatelessWidget {
  const ImageField({
    this.image,
    super.key,
    required this.title,
    this.width,
    this.height,
    this.radius,
    this.errorMessage,
  });

  final File? image;
  final String title;
  final double? width;
  final double? height;
  final double? radius;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Text(
            title,
            style: medium.copyWith(fontSize: heading2),
          ),
          const SizedBox(
            height: 10,
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(radius ?? 10),
            dashPattern: const [10, 4],
            strokeWidth: 2,
            color: Colors.grey.shade500,
            child: Container(
              width: width ?? double.infinity,
              height: height ?? 150,
              padding:
                  EdgeInsets.all(image != null ? 0 : defaultMargin / 2),
              margin:
                  EdgeInsets.all(image != null ? defaultMargin / 2 : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 10),
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
          errorMessage != null
          ?
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          )
          :
          const SizedBox(),
        ],
      ),
    );
  }
}

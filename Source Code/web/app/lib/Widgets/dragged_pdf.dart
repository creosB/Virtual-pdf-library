import 'package:dotted_border/dotted_border.dart'; // customize border library
import 'package:virtuallibrary/Data/dragged_file_data.dart';
import 'package:flutter/material.dart';

class DraggedPDFWidget extends StatelessWidget {
  final DraggedFile? file;

  const DraggedPDFWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildPDF(),
          if (file != null) fileDetailsWidget(file!),
        ],
      );

  // when you uploaded pdf, it will change empty picture box with this gif
  Widget buildPDF() {
    // when image box was empty, it will write this message
    if (file == null) return emptyfileWidget(":(");
    // it will change empty picture box with this gif
    return Image.network(
      'https://cdn.dribbble.com/users/2046015/screenshots/15390369/media/6c2d9f4e04b72d24849cec34b79f3850.gif',
      width: 200,
      height: 200,
      fit: BoxFit.cover,
      errorBuilder: (context, error, _) => emptyfileWidget(":("),
    );
  }

  // when image box was empty, it's creating text and adding picture
  Widget emptyfileWidget(String message) => SizedBox(
        width: 200,
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: const Color.fromRGBO(61, 96, 152, 1),
            padding: const EdgeInsets.all(15),
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: Colors.white,
              strokeWidth: 3,
              dashPattern: const [12, 4],
              padding: EdgeInsets.zero,
              radius: const Radius.circular(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.hide_image_sharp,
                      size: 32,
                      color: Color.fromRGBO(231, 231, 231, 1),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
// show file information on right
  Widget fileDetailsWidget(DraggedFile file) {
    TextStyle _styles =
        const TextStyle(fontSize: 14, color: Color.fromRGBO(231, 231, 231, 1));
    return Container(
      width: 250,
      height: 120,
      margin: const EdgeInsets.only(left: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: const Color.fromRGBO(61, 96, 152, 1),
          padding: const EdgeInsets.all(10),
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.white,
            strokeWidth: 3,
            dashPattern: const [12, 4],
            padding: EdgeInsets.zero,
            radius: const Radius.circular(10),
            child: Center(
              widthFactor: 200,
              heightFactor: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5),
                  FittedBox(
                    child: Text(
                      file.name,
                      style: _styles.copyWith(fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    file.mime,
                    style: _styles,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    file.calculateSize,
                    style: _styles,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

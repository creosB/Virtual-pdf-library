import 'package:dotted_border/dotted_border.dart'; // customize border library
import 'package:virtuallibrary/Data/dragged_file_data.dart';
import 'package:flutter/material.dart';

class DraggedPDFWidget extends StatefulWidget {
  final DraggedFile? file;

  const DraggedPDFWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<DraggedPDFWidget> createState() => _DraggedPDFWidgetState();
}

class _DraggedPDFWidgetState extends State<DraggedPDFWidget> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildPDF(),
          if (widget.file != null) fileDetailsWidget(widget.file!),
        ],
      );

  Widget buildPDF() {
    // when image box was empty, it will write this message
    if (widget.file == null) return emptyfileWidget(":(");
    // it will change empty picture box with this gif
    return Image.asset(
      "assets/images/uploaded.gif",
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
    );
    //Text("Uploading...");
  }

  Widget emptyfileWidget(String message) => SizedBox(
        width: 200,
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: const Color.fromRGBO(108, 61, 195, 0.7),
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

  Widget fileDetailsWidget(DraggedFile file) {
    TextStyle _styles = const TextStyle(color: Colors.white, fontSize: 14);
    return Expanded(
      flex: 1,
      child: Container(
        width: 250,
        height: 120,
        margin: const EdgeInsets.only(left: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: const Color.fromRGBO(108, 61, 195, 0.7),
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
                    const SizedBox(height: 8),
                    FittedBox(
                      child: Text(
                        file.name.length > 30
                            ? file.name.substring(0, 30) + "..."
                            : file.name,
                        style: _styles,
                        textAlign: TextAlign.center,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      file.mime,
                      style: _styles.copyWith(fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      file.calculateSize,
                      style: _styles.copyWith(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

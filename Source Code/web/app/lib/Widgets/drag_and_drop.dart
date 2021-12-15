import 'package:dotted_border/dotted_border.dart'; // customize border library
import 'package:flutter/material.dart'; // basic library
import 'package:flutter_dropzone/flutter_dropzone.dart'; // area decoration
import 'package:virtuallibrary/Data/dragged_file_data.dart'; // drag and drop library
import 'package:virtuallibrary/api/fileapi.dart';
import 'package:virtuallibrary/Data/filedata.dart';
import 'package:provider/provider.dart';

class DragandDropWidget extends StatefulWidget {
  final ValueChanged<DraggedFile> onDraggedFile;

  const DragandDropWidget({
    Key? key,
    required this.onDraggedFile,
  }) : super(key: key);

  @override
  _DragandDropWidgetState createState() => _DragandDropWidgetState();
}

class _DragandDropWidgetState extends State<DragandDropWidget> {
  late DropzoneViewController _controller; // drag and drop library _controller
  bool isColorChanged = false; // check highlighter color

  void onAdd(String name, String size, String data) {
    final String names = name;
    final String sizes = size;
    final String datas = data;

    if (names.isNotEmpty && sizes.isNotEmpty && datas.isNotEmpty) {
      final FileData file = FileData(name: names, size: sizes, data: datas);
      Provider.of<FileProvider>(context, listen: false).addFiles(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set All Area Color
    final browseColor =
        isColorChanged ? Colors.black : const Color.fromRGBO(231, 231, 231, 1);
    final dragAreaColor = isColorChanged
        ? const Color.fromRGBO(61, 96, 152, 1)
        : const Color.fromRGBO(33, 49, 89, 1);

    return areaDecoration(
      child: Stack(
        children: <Widget>[
          // Drag and drop area
          DropzoneView(
              // drag and drop library _controller
              onCreated: (_controller) => this._controller = _controller,
              // when you came the hover area, color will change.
              onHover: () => setState(() => isColorChanged = true),
              onLeave: () => setState(() => isColorChanged = false),
              onDrop: uploadedFile), // call file has been uploaded function
          // Drag and drop text area
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // drag and drop icon
                Icon(
                  Icons.cloud_upload_sharp,
                  size: 80,
                  color: browseColor,
                ),
                Text(
                  "Drag and Drop Here\nOr",
                  style: TextStyle(color: browseColor, fontSize: 24),
                ),
                const SizedBox(height: 30),
                // Browse and upload button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 36),
                    primary: dragAreaColor,
                    shape: const RoundedRectangleBorder(),
                  ),
                  icon: Icon(
                    Icons.search,
                    size: 32,
                    color: browseColor,
                  ),
                  label: Text(
                    "Browse Files",
                    style: TextStyle(color: browseColor, fontSize: 16),
                  ),
                  // call file has been uploaded function
                  onPressed: () async {
                    final _actions = await _controller.pickFiles();
                    if (_actions.isEmpty) return;
                    uploadedFile(_actions.first);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget areaDecoration({required Widget child}) {
    final backgroundColor = isColorChanged
        ? const Color.fromRGBO(61, 96, 152, 1)
        : const Color.fromRGBO(33, 49, 89, 1);
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(15),
        child: DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.white,
            strokeWidth: 3,
            dashPattern: const [12, 4],
            padding: EdgeInsets.zero,
            radius: const Radius.circular(20),
            child: child),
      ),
    );
  }

  // Get uploaded file and use make actions
  Future uploadedFile(dynamic action) async {
    // get file information and define the value
    final getFileName = action.name; // get file name
    final mime = await _controller.getFileMIME(action); // get file type
    final bytes = await _controller.getFileSize(action); // get file size
    final url =
        await _controller.createFileUrl(action); // get file link on site
    final data = await _controller.getFileData(action); // get full file
    // final name = await _controller.getFilename(action);
/*
    print("File: $GetFileName");
    print("File: $mime");
    print("File: $Bytes");
    print("File: $url");
*/

    if (mime != "application/pdf") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: const <Widget>[
            Icon(
              Icons.error_outline_outlined,
              size: 40.0,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Text(
              "Only PDF file can be uploaded",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ],
        ),
      ));
      return; //print("Not PDF");
    }

    // set widget with giving file information
    final draggedFile = DraggedFile(
        url: url, name: getFileName, mime: mime, size: bytes, data: data);
    // call widget
    widget.onDraggedFile(draggedFile);
    // when you uploaded the file, it will set color to default.
    setState(() => isColorChanged = false);

    // call to function and add pdf file
    onAdd(getFileName, draggedFile.calculateSize, data.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const <Widget>[
            Icon(
              Icons.done_outlined,
              size: 40.0,
              color: Colors.green,
            ),
            SizedBox(width: 10),
            Text(
              "Pdf file successfully uploaded",
              style: TextStyle(color: Colors.green, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

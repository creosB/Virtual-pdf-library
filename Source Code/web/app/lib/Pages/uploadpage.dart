import 'package:flutter/material.dart';
import 'package:virtuallibrary/Data/dragged_file_data.dart';
import 'package:virtuallibrary/Widgets/drag_and_drop.dart';
import 'package:virtuallibrary/Widgets/dragged_pdf.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  DraggedFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(78, 65, 191, 1),
      appBar: AppBar(
        title: const Text(
          "Virtual  Upload  Center",
          style: TextStyle(
              color: Colors.white, fontFamily: 'Agrandir', fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(108, 61, 195, 1),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DraggedPDFWidget(file: file),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 300,
                  child: DragandDropWidget(
                    onDraggedFile: (_file) => setState(() {
                      file = _file;
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

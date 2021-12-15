import 'package:flutter/material.dart';
import 'package:virtuallibrary/Data/dragged_file_data.dart';
import 'package:virtuallibrary/Pages/download.dart';
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
      appBar: AppBar(
        title: const Text(
          "Virtual Upload Page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(231, 231, 231, 1),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DraggedPDFWidget(file: file),
            const SizedBox(
              height: 16,
            ),
            IconButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 20),
                      content: const SizedBox(
                        height: 100,
                        child: Download(),
                      ),
                      action: SnackBarAction(
                        label: "Cancel",
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.cloud_upload)),
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
    );
  }
}

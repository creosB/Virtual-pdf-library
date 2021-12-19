import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtuallibrary/Data/filedata.dart';
import 'package:virtuallibrary/Widgets/search.dart';
import 'package:virtuallibrary/api/fileapi.dart';

class FileList extends StatefulWidget {
  const FileList({Key? key}) : super(key: key);

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  List<FileData> itemList = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 100),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final itemList = await FileProvider.getBooks(query);

    setState(() => this.itemList = itemList);
    searchFile(query);
  }

  @override
  Widget build(BuildContext context) {
    final fileList = Provider.of<FileProvider>(context, listen: false);

    if (itemList.isEmpty) {
      itemList = fileList.files.toList();
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(78, 65, 191, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(108, 61, 195, 1),
      ),
      body: (itemList.isNotEmpty)
          ? Column(
              children: <Widget>[
                buildSearch(),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      final tempList = itemList[index];

                      return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          elevation: 10,
                          color: const Color.fromRGBO(108, 61, 195, 0.5),
                          child: buildFile(tempList, fileList));
                    },
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search PDF File',
        onChanged: searchFile,
      );

  Future searchFile(String query) async => debounce(() async {
        final itemList = await FileProvider.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.itemList = itemList;
        });
      });

  Future deleteFile(FileData file) async {
    await FileProvider.deleteFile(file);
    final list = await FileProvider.fetchTasks();
    setState(() {
      itemList = list;
    });
  }

  Widget buildFile(FileData file, FileProvider fileList) => ListTile(
      trailing: Wrap(
        spacing: 12,
        children: <Widget>[
          IconButton(
              hoverColor: const Color.fromRGBO(108, 61, 195, 1),
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                deleteFile(file);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    backgroundColor: const Color.fromRGBO(108, 61, 195, 1),
                    elevation: 10,
                    content: Row(
                      children: const <Widget>[
                        Icon(
                          Icons.delete_forever_outlined,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Pdf file successfully deleted",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          IconButton(
              hoverColor: const Color.fromRGBO(108, 61, 195, 1),
              icon: const Icon(Icons.download, color: Colors.white),
              onPressed: () async {
                fileList.downloadPdf(file);
              }),
          IconButton(
              hoverColor: const Color.fromRGBO(108, 61, 195, 1),
              icon: const Icon(Icons.visibility_rounded, color: Colors.white),
              onPressed: () async {
                fileList.openPdf(file);
              })
        ],
      ),
      leading: Image.asset(
        'assets/images/encoded.png',
        width: 70,
        height: 90,
        fit: BoxFit.fill,
      ),
      title: Text(
        file.name,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      subtitle: Text(
        file.size,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ));
  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }
}

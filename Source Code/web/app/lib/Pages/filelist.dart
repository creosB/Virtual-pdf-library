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

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
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
      appBar: AppBar(
        centerTitle: true,
      ),
      body: (itemList.isNotEmpty)
          ? Column(
              children: <Widget>[
                buildSearch(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      final tempList = itemList[index];

                      return buildFile(tempList, fileList);
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
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                deleteFile(file);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    content: Row(
                      children: const <Widget>[
                        Icon(
                          Icons.delete_forever_outlined,
                          size: 40.0,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Pdf file successfully deleted",
                          style: TextStyle(color: Colors.green, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          IconButton(
              icon: const Icon(Icons.download, color: Colors.black),
              onPressed: () async {
                fileList.downloadPdf(file);
              }),
          IconButton(
              icon: const Icon(Icons.visibility_rounded, color: Colors.black),
              onPressed: () async {
                fileList.openPdf(file);
              })
        ],
      ),
      title: Text(
        file.name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        file.size,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ));
}

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:virtuallibrary/Data/filedata.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class FileProvider with ChangeNotifier {
  FileProvider() {
    fetchTasks();
  }

  static List<FileData> _files = [];

  List<FileData> get files {
    return [..._files];
  }

  void addFiles(FileData file) async {
    final response =
        await http.post(Uri.parse('http://127.0.0.1:8000/fileapi/v1/'),
            headers: {
              "Content-Type": "application/json",
            },
            body: json.encode(file));
    if (response.statusCode == 201) {
      file.id = json.decode(response.body)['id'];
      _files.add(file);
      notifyListeners();
    }
  }

  static Future<void> deleteFile(FileData file) async {
    final response = await http
        .delete(Uri.parse('http://127.0.0.1:8000/fileapi/v1/${file.id}'));
    if (response.statusCode == 204) {
      _files.remove(file);
      // _files.remove(file);
      // notifyListeners();
    }
  }

  void openPdf(FileData file) async {
    String getFileData = file.data.replaceAll("[", '').replaceAll("]", "");
    List<String> fileDataList = getFileData.split(',');
    List<int> fileIntList = fileDataList.map(int.parse).toList();
    Uint8List bytes = Uint8List.fromList(fileIntList);

    final blob = html.Blob([bytes], 'application/pdf');
    final _url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(_url, '_blank'); // open new page
    html.Url.revokeObjectUrl(_url); // delete url */
  }

  void downloadPdf(FileData file) async {
    String getFileData = file.data.replaceAll("[", '').replaceAll("]", "");
    List<String> fileDataList = getFileData.split(',');
    List<int> fileIntList = fileDataList.map(int.parse).toList();
    Uint8List bytes = Uint8List.fromList(fileIntList);

    final blob = html.Blob([bytes], 'application/pdf');
    final _url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement()
      ..href = _url
      ..style.display = 'none'
      ..download = '${file.name}.pdf';
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(_url);
  }

  static Future<List<FileData>> getBooks(String query) async {
    final url = Uri.parse('http://127.0.0.1:8000/fileapi/v1/?format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List files = json.decode(response.body);

      return files.map((json) => FileData.fromJson(json)).where((files) {
        final fileName = files.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return fileName.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<FileData>> fetchTasks() async {
    const url = 'http://127.0.0.1:8000/fileapi/v1/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _files = data.map<FileData>((json) => FileData.fromJson(json)).toList();
      return _files;
      // notifyListeners();
    } else {
      throw Exception();
    }
  }
}

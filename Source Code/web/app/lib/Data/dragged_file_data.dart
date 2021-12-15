import 'dart:typed_data';

class DraggedFile {
  // value map
  final String url;
  final String name;
  final String mime;
  final int size;
  final Uint8List data;

  const DraggedFile({
    required this.url,
    required this.name,
    required this.mime,
    required this.size,
    required this.data,
  });

// Calculate pdf file size and return
  String get calculateSize {
    final kb = size / 1024;
    final mb = kb / 1024;
    final gb = mb / 1024;

    if (gb > 1) {
      return "${gb.toStringAsFixed(2)} gb";
    } else if (mb > 1) {
      return "${mb.toStringAsFixed(2)} mb";
    } else {
      return "${kb.toStringAsFixed(2)} kb";
    }
  }
}

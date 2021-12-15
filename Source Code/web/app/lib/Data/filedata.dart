// map the file information
class FileData {
  int? id;
  final String name;
  final String size;
  final String data;

  FileData(
      {this.id, required this.name, required this.size, required this.data});
  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
        id: json['id'],
        name: json['name'],
        size: json['size'],
        data: json['data']);
  }
  dynamic toJson() => {'id': id, 'name': name, 'size': size, 'data': data};
}

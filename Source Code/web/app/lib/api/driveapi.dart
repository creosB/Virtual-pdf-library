import 'dart:convert';

enum Type { google, onedrive, dropbox, empty }

class DriveApi {
  // value map
  final String url;

  const DriveApi({required this.url});

  Type get driveType {
    if (url.toLowerCase().contains('drive.google.com/file/d/')) {
      return Type.google;
    } else if (url.toLowerCase().contains('1drv.ms')) {
      return Type.onedrive;
    } else if (url.toLowerCase().contains('dropbox.com/s/')) {
      return Type.dropbox;
    } else {
      return Type.empty;
    }
  }

// Match drive type and set link to direct download link
  String get convertedUrl {
    if (driveType == Type.google) {
      String _tempUrl = "https://drive.google.com/uc?export=download&id=";
      return _tempUrl +
          url
              .trim()
              .toString()
              .split('https://drive.google.com/file/d/')
              .last
              .split('/view?usp=sharing')
              .first;
    } else if (driveType == Type.onedrive) {
      String _tempUrl = url.trim();
      _tempUrl = base64.encode(utf8.encode(_tempUrl));
      String _converted =
          "u!" + _tempUrl.replaceAll('/', '_').replaceAll('+', '-');

      return ("https://api.onedrive.com/v1.0/shares/${_converted}" +
          "/root/content");
    } else if (driveType == Type.dropbox) {
      String _tempUrl = "https://dl.dropboxusercontent.com/s/";
      return _tempUrl +
          url.trim().toString().split('https://www.dropbox.com/s/').last;
    }
    {
      return "We are not supporting this drive type";
    }
  }
}

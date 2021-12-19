import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'dart:html' as html;
import 'package:virtuallibrary/api/driveapi.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  _DownloadState createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Theme(
          data: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            primaryColor: Colors.white,
            hintColor: Colors.white,
            primaryColorDark: Colors.white,
            primaryColorLight: Colors.white,
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.white,
              textTheme: ButtonTextTheme.primary,
            ),
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'Support for',
                    ),
                    SizedBox(width: 10),
                    Icon(
                      SimpleIcons.microsoftonedrive,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      SimpleIcons.googledrive,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      SimpleIcons.dropbox,
                      color: Colors.white,
                    ),
                  ],
                ),
                // get user name field
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'File Link',
                    hintText: 'type here...',
                  ),
                  onChanged: (value) {
                    // do something with the user name
                    final wrotedString = DriveApi(url: value).convertedUrl;
                    if (wrotedString ==
                        "We are not supporting this drive type") {
                      return; // print("Failed");
                    }
                    html.AnchorElement anchorElement = html.AnchorElement()
                      ..href = wrotedString
                      ..style.display = 'none';
                    html.document.body?.children.add(anchorElement);

                    anchorElement.click();
                    anchorElement.remove();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

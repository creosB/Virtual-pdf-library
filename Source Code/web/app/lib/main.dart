import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtuallibrary/Pages/filelist.dart';
import 'package:virtuallibrary/Pages/mainpage.dart';
import 'package:virtuallibrary/api/fileapi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FileProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            '/': (context) => const Mainpage(),
            '/filelist': (BuildContext context) => const FileList(),
          },
        ));
  }
}

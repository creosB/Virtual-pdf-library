import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtuallibrary/Pages/anasayfa.dart';
import 'package:virtuallibrary/Pages/filelist.dart';
import 'package:virtuallibrary/Pages/login.dart';
import 'package:virtuallibrary/api/fileapi.dart';

Future<void> main() async {
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
            '/': (context) => const Anasayfa(),
            '/login': (BuildContext context) => const LoginScreen(),
            '/forgotPass': (BuildContext context) =>
                const ForgotPasswordScreen(),
            '/filelist': (BuildContext context) => const FileList(),
          },
        ));
  }
}

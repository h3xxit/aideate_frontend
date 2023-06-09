import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:watchat_ui/controller/reqController.dart';
import 'package:watchat_ui/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIdeation',
      theme: ThemeData(
        fontFamily: "Lato",
      ),
      home: const Scaffold(body: MainPage()),
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

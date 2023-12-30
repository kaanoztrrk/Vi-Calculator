import 'package:calculator/Constant.dart';
import 'package:calculator/Page/Components/Home.dart';
import 'package:calculator/Util/TextUtility.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
          scaffoldBackgroundColor: bgColor,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: iconColor),
            color: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          )),
      home: const Home(),
    );
  }
}

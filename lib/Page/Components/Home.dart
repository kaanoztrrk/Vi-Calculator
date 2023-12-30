// ignore_for_file: file_names

import 'package:calculator/Constant.dart';
import 'package:calculator/Page/BasicCalculator.dart';
import 'package:flutter/material.dart';

import '../../Components/CustomAppBar.dart';
import '../MoreApps.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomAppBar(
            more: () => controller.jumpToPage(2),
            add: () => controller.jumpToPage(1),
            equal: () => controller.jumpToPage(0),
          )),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          const BasicCalculator(),
          MoreApps(),
          Container(color: bgColor),
        ],
      ),
    );
  }
}

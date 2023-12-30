import 'dart:math';

import 'package:calculator/Widget/Textfield.dart';
import 'package:flutter/material.dart';

import '../../Constant.dart';
import '../../Util/Size.dart';
import '../../Widget/CalculateButton.dart';

class Trigonometry extends StatefulWidget {
  static const String title = "Trigonometri";
  @override
  _TrigonometryState createState() => _TrigonometryState();
}

class _TrigonometryState extends State<Trigonometry> {
  bool visible = false;
  TextEditingController _angleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            KTextField(
                title: "Açı", state: " derece", controller: _angleController),
            Visibility(
                visible: visible == true ? false : true,
                child: CalculateButton(
                    onTap: () => _calculateTrigonometricFunctions())),
            Visibility(
                visible: visible,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: secondColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Result",
                        style: textTheme(context)
                            .headlineLarge
                            ?.copyWith(color: textColor),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "Natural Log : ",
                          style: textTheme(context).headlineSmall?.copyWith(
                              color: textColor, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          "",
                          style: textTheme(context).titleLarge?.copyWith(
                              color: textColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "Base 10 Log : ",
                          style: textTheme(context).headlineSmall?.copyWith(
                              color: textColor, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          "",
                          style: textTheme(context).titleLarge?.copyWith(
                              color: textColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      title: const Text(Trigonometry.title, style: TextStyle(color: textColor)),
      actions: visible
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Trigonometry(),
                        ));
                  },
                  icon: const Icon(Icons.refresh_outlined))
            ]
          : [],
    );
  }

  void _calculateTrigonometricFunctions() {
    try {
      double angle = double.parse(_angleController.text);
      double angleInRadians = angle * (pi / 180.0);

      double sinValue = sin(angleInRadians);
      double cosValue = cos(angleInRadians);
      double tanValue = tan(angleInRadians);

      setState(() {
        visible = !visible;
      });
    } catch (e) {
      setState(() {});
    }
  }
}

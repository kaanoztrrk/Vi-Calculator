import 'dart:math';

import 'package:calculator/Widget/CalculateButton.dart';
import 'package:calculator/Widget/Textfield.dart';
import 'package:flutter/material.dart';

import '../../Constant.dart';
import '../../Util/Size.dart';

class LOG extends StatefulWidget {
  static const String title = "Logaritma";

  _LOGState createState() => _LOGState();
}

class _LOGState extends State<LOG> {
  TextEditingController _numberController = TextEditingController();
  String _naturalLOG = "";
  String _base10LOG = "";
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            KTextField(title: "Number", controller: _numberController),
            const SizedBox(height: 16),
            Visibility(
                visible: visible == true ? false : true,
                child: CalculateButton(onTap: () => _calculateLogarithms())),
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
                          "$_naturalLOG",
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
                          "$_base10LOG",
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
      title: const Text(LOG.title, style: TextStyle(color: textColor)),
      actions: visible
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LOG(),
                        ));
                  },
                  icon: const Icon(Icons.refresh_outlined))
            ]
          : [],
    );
  }

  void _calculateLogarithms() {
    try {
      double number = double.parse(_numberController.text);
      if (number <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pozitif bir Sayı olmalı"),
          ),
        );
        return;
      }

      // Doğal Logaritma Hesaplama
      double naturalLogarithm = log(number);
      // Onlu Logaritma Hesaplama
      double base10Logarithm = log(number) / log(10);

      String finalnaturalLogarithm = naturalLogarithm.toStringAsFixed(4);
      String finalbase10Logarithm = base10Logarithm.toStringAsFixed(1);

      setState(() {
        _naturalLOG = finalnaturalLogarithm;
        _base10LOG = finalbase10Logarithm;
        visible = !visible;
      });
    } catch (e) {
      setState(() {});
    }
  }
}

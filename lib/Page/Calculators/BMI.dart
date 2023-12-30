// ignore_for_file: file_names

import 'package:calculator/Widget/CalculateButton.dart';
import 'package:calculator/Widget/Textfield.dart';
import 'package:flutter/material.dart';

import 'package:calculator/Constant.dart';
import 'package:calculator/Util/Size.dart';

import '../../Util/TextUtility.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});
  static const String title = "BMI";

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  bool visible = false;
  int currentIndex = 0;
  double heigth = 0;
  double weigth = 0;
  String result = "";
  String resultBorderText = "";
  Color resultColor = Colors.transparent;

  TextEditingController heigthController = TextEditingController();
  TextEditingController weigthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              manOrWomen(),
              KTextField(
                  title: bmi_higth,
                  state: state_heigth,
                  controller: heigthController),
              KTextField(
                  title: bmi_weigth,
                  state: state_weigth,
                  controller: weigthController),
              Visibility(
                  visible: visible == true ? false : true,
                  child:
                      CalculateButton(onTap: () => validate(heigth, weigth))),
              Visibility(
                visible: visible,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        bmiTitle(),
                        bmiLinearMap(),
                        bmiLinearMapText(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validate(heigth, weigth) {
    if (heigthController.text != "" && weigthController.text != "") {
      setState(() {
        heigth = double.parse(heigthController.text);
        weigth = double.parse(weigthController.text);
      });
      calculateBmi(heigth, weigth);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(emtyErrorText),
        ),
      );
    }
  }

  void calculateBmi(double heigth, double weigth) {
    double finalresult = weigth / (heigth * heigth / 10000);
    String bmi = finalresult.toStringAsFixed(2);

    setState(() {
      result = bmi;
      visible = !visible;
      if (finalresult < 18.5) {
        resultColor = const Color(0xFF87B1D9);
        resultBorderText = bmi_underweigth;
      } else if (finalresult >= 18.5 && finalresult <= 24.9) {
        resultColor = const Color(0xFF3DD365);
        resultBorderText = bmi_normal;
      } else if (finalresult >= 25 && finalresult <= 29.9) {
        resultColor = const Color(0xFFEEE133);
        resultBorderText = bmi_normal;
      } else if (finalresult >= 30 && finalresult <= 34.9) {
        resultColor = const Color(0xFFFD802E);
        resultBorderText = bmi_owerWeigth;
      } else if (finalresult >= 35) {
        resultColor = const Color(0xFFF95353);
        resultBorderText = bmi_owerWeigth;
      }
    });
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      title: const Text(BMI.title, style: TextStyle(color: textColor)),
      actions: visible
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BMI(),
                        ));
                  },
                  icon: const Icon(Icons.refresh_outlined))
            ]
          : [],
    );
  }

  Widget manOrWomen() {
    return Row(
      children: [
        ratioButton(man, selectedColor, 0),
        ratioButton(women, selectedColor, 1),
      ],
    );
  }

  Widget ratioButton(String value, Color color, int index) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              backgroundColor: currentIndex == index ? color : secondColor),
          onPressed: () {
            return changeIndex(index);
          },
          child: Text(
            value,
            style: TextStyle(
              color: currentIndex == index ? textColor : color,
            ),
          )),
    ));
  }

  Widget bmiTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(result,
            style: textTheme(context)
                .displayLarge
                ?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
        const SizedBox(width: 8.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(BMI.title,
                style: textTheme(context)
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
            Text(resultBorderText,
                style: textTheme(context).titleMedium?.copyWith(
                    fontWeight: FontWeight.bold, color: resultColor)),
          ],
        ),
      ],
    );
  }

  Widget bmiLinearMap() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 4,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF87B1D9),
            Color(0xFF3DD365),
            Color.fromARGB(255, 211, 196, 61),
            Color(0xFFF95353),
          ])),
        ),
      ],
    );
  }

  Widget bmiLinearMapText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        bmiLinearMapItem(bmi_underweigth),
        bmiLinearMapItem(bmi_normal),
        bmiLinearMapItem(bmi_owerWeigth),
      ],
    );
  }

  Widget bmiLinearMapItem(String title) {
    return Column(
      children: [
        const Icon(Icons.arrow_drop_up_rounded, color: Colors.white),
        Text(
          title,
          style: textTheme(context).bodySmall?.copyWith(color: textColor),
        ),
      ],
    );
  }
}

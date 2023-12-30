// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:calculator/Constant.dart';
import 'package:calculator/Widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class BasicCalculator extends StatefulWidget {
  const BasicCalculator({super.key});

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  var userQuestion = "";
  var userAnswer = "";

  @override
  Widget build(BuildContext context) {
    List<String> buttons = [
      "C",
      "Del",
      "%",
      "/",
      "7",
      "8",
      "9",
      "x",
      "4",
      "5",
      "6",
      "-",
      "1",
      "2",
      "3",
      "+",
      "0",
      ".",
      "ans",
      "=",
    ];

    bool isOperator(String x) {
      if (x == '%' ||
          x == '/' ||
          x == 'x' ||
          x == '-' ||
          x == '+' ||
          x == '=') {
        return true;
      }
      return false;
    }

    void equelPressed() {
      String finalQuestion = userQuestion;
      finalQuestion = finalQuestion.replaceAll("x", "*");
      Parser p = Parser();

      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        userAnswer = eval.toString();
      });
    }

    void deleteLastItem() {
      if (userQuestion == "") {
        return;
      } else {
        setState(() {
          userQuestion = userQuestion.substring(0, userQuestion.length - 1);
        });
      }
    }

    void _onDoubleTap() {
      setState(() => userQuestion = "");
      setState(() => userAnswer = "");
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                _userQuestion(userQuestion, Alignment.bottomRight),
                const SizedBox(height: 10),
                _userAnswer(userAnswer, Alignment.bottomRight),
                const SizedBox(height: 20),
              ],
            ),
          )),
          Expanded(
            flex: 2,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                var button = buttons[index];
                // Clear
                if (index == 0) {
                  return CalculatorButton(
                    onTap: () => setState(() => userQuestion = ""),
                    onDoubleTap: _onDoubleTap,
                    buttonText: button,
                    color: isOperator(button) ? primaryColor : secondColor,
                    textColor: isOperator(button) ? textColor : textColor,
                  );
                  // Delete Last Item
                } else if (index == 1) {
                  return CalculatorButton(
                    onTap: deleteLastItem,
                    buttonText: buttons[index],
                    color: isOperator(button) ? primaryColor : secondColor,
                    textColor: isOperator(button) ? textColor : textColor,
                  );
                }
                // Equel
                else if (index == buttons.length - 1) {
                  return CalculatorButton(
                    buttonText: button,
                    onTap: () => setState(() => equelPressed()),
                    color: isOperator(button) ? primaryColor : secondColor,
                    textColor: isOperator(button) ? textColor : textColor,
                  );
                } else {
                  return CalculatorButton(
                    buttonText: button,
                    onTap: () => setState(() => userQuestion += buttons[index]),
                    color: isOperator(button) ? primaryColor : secondColor,
                    textColor: isOperator(button) ? textColor : textColor,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _userAnswer(String title, AlignmentGeometry alignment) {
    return Container(
      alignment: alignment,
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: answerTextColor,
            ),
      ),
    );
  }

  Container _userQuestion(String title, AlignmentGeometry alignment) {
    return Container(
        alignment: alignment,
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: questionTextColor.withOpacity(0.5),
              ),
        ));
  }
}

// ignore_for_file: file_names

import 'package:calculator/Util/TextUtility.dart';
import 'package:calculator/Widget/CalculateButton.dart';
import 'package:calculator/Widget/Textfield.dart';
import 'package:flutter/material.dart';

import '../../Constant.dart';
import '../../Util/Size.dart';

class EMI extends StatefulWidget {
  const EMI({super.key});
  static const String title = "EMI";

  @override
  State<EMI> createState() => _EMIState();
}

class _EMIState extends State<EMI> {
  bool visible = false;
  double amount = 0;
  double interest = 0;
  double maturity = 0;
  String faizTutari = "";
  String toplamTutar = "";
  TextEditingController anaParaController = TextEditingController();
  TextEditingController faizOraniController = TextEditingController();
  TextEditingController vadeSuresiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              KTextField(
                  title: amount_text,
                  state: state_money,
                  controller: anaParaController),
              KTextField(
                  title: interest_text,
                  state: state_percent,
                  controller: faizOraniController),
              KTextField(
                  title: matuity_text,
                  state: state_day,
                  controller: vadeSuresiController),
              Visibility(
                  visible: visible == true ? false : true,
                  child: CalculateButton(
                      onTap: () => validate(amount, interest, maturity))),
              Visibility(
                  visible: visible,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: secondColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result_text,
                          style: textTheme(context)
                              .headlineLarge
                              ?.copyWith(color: textColor),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Interest",
                            style: textTheme(context).headlineSmall?.copyWith(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "$faizTutari ₺",
                            style: textTheme(context).titleLarge?.copyWith(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Total Amount : ",
                            style: textTheme(context).headlineSmall?.copyWith(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "$toplamTutar ₺",
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
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      title: const Text(EMI.title, style: TextStyle(color: textColor)),
      actions: visible
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EMI(),
                        ));
                  },
                  icon: const Icon(Icons.refresh_outlined))
            ]
          : [],
    );
  }

  void validate(amount, interest, maturity) {
    if (anaParaController.text != "" &&
        faizOraniController.text != "" &&
        vadeSuresiController.text != "") {
      setState(() {
        amount = double.parse(anaParaController.text);
        interest = double.parse(faizOraniController.text);
        maturity = double.parse(vadeSuresiController.text);
      });
      _emiCalculate(amount, interest, maturity);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You cannot leave your price and tax blank"),
        ),
      );
    }
  }

  void _emiCalculate(amount, interest, maturity) {
    double faiz = (amount / 100) * (interest / 365) * maturity;
    double toplam = amount + faiz;
    String finalFaiz = faiz.toStringAsFixed(2);
    String finalToplam = toplam.toStringAsFixed(2);

    setState(() {
      faizTutari = finalFaiz;
      toplamTutar = finalToplam;
      visible = !visible;
    });
  }

  Widget textfieldWidget(
    String title,
    String state,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: textTheme(context).headlineMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: TextField(
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: controller,
              style: textTheme(context)
                  .displayLarge
                  ?.copyWith(color: Colors.orangeAccent),
              decoration: InputDecoration(
                  hintText: "0",
                  hintStyle: textTheme(context)
                      .displayLarge
                      ?.copyWith(color: textColor),
                  border:
                      const OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ],
      ),
    );
  }
}

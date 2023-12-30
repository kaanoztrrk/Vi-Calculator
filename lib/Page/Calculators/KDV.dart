// ignore_for_file: file_names

import 'package:calculator/Widget/Textfield.dart';
import 'package:flutter/material.dart';

import '../../Constant.dart';
import '../../Util/Size.dart';
import '../../Util/TextUtility.dart';
import '../../Widget/CalculateButton.dart';

class KDV extends StatefulWidget {
  const KDV({super.key});
  static const String title = "KDV";

  @override
  State<KDV> createState() => _KDVState();
}

class _KDVState extends State<KDV> {
  bool visible = false;
  double amount = 0;
  double tax = 0;
  String result = "";
  String totalResult = "";
  TextEditingController amountController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              KTextField(
                  title: amount_text,
                  state: state_money,
                  controller: amountController),
              KTextField(
                  title: kdv_tax,
                  state: state_percent,
                  controller: taxController),
              Visibility(
                  visible: visible == true ? false : true,
                  child: CalculateButton(onTap: () => validate(amount, tax))),
              Visibility(
                  visible: visible,
                  child: Container(
                    padding: const EdgeInsets.all(20),
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
                            kdv_result_tax,
                            style: textTheme(context).headlineSmall?.copyWith(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "$result ₺",
                            style: textTheme(context).titleLarge?.copyWith(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            kdv_result_amount_tax,
                            style: textTheme(context).headlineSmall?.copyWith(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "$totalResult ₺",
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
      title: const Text(KDV.title, style: TextStyle(color: textColor)),
      actions: visible
          ? [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KDV(),
                        ));
                  },
                  icon: const Icon(Icons.refresh_outlined))
            ]
          : [],
    );
  }

  void validate(price, tax) {
    if (amountController.text != "" && taxController.text != "") {
      setState(() {
        price = double.parse(amountController.text);
        tax = double.parse(taxController.text);
        visible = !visible;
      });
      kdvCalculate(price, tax);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You cannot leave your price and tax blank"),
        ),
      );
    }
  }

  void kdvCalculate(price, tax) {
    double finalResult = (price * tax) / 100;
    double finalTotalResult = price + finalResult;
    String kdv = finalResult.toStringAsFixed(2);

    setState(() {
      result = kdv;
      totalResult = finalTotalResult.toString();
    });
    print(result);
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

import 'package:flutter/material.dart';

import '../Constant.dart';
import '../Util/Size.dart';
import '../Util/TextUtility.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            calculateButtonText,
            textAlign: TextAlign.center,
            style:
                textTheme(context).headlineMedium?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

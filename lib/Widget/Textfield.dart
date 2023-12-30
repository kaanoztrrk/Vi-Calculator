import 'package:flutter/material.dart';

import '../Constant.dart';
import '../Util/Size.dart';

class KTextField extends StatelessWidget {
  const KTextField({
    super.key,
    this.state = "",
    required this.title,
    required this.controller,
  });

  final String title;
  final String state;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme(context).headlineSmall?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  state,
                  style: textTheme(context).bodySmall?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              cursorOpacityAnimates: true,
              cursorColor: selectedColor,
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: controller,
              style: textTheme(context)
                  .displayLarge
                  ?.copyWith(color: selectedColor),
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

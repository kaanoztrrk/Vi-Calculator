// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.equal, this.add, this.more});

  final Function()? equal;
  final Function()? add;
  final Function()? more;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _AppBarActionIconWidget(
            onTap: equal,
            icon: "equal",
          ),
          _AppBarActionIconWidget(
            onTap: add,
            icon: "add",
          ),
          _AppBarActionIconWidget(
            onTap: more,
            icon: "more",
          ),
        ],
      ),
    );
  }
}

class _AppBarActionIconWidget extends StatelessWidget {
  const _AppBarActionIconWidget({
    required this.onTap,
    required this.icon,
  });

  final Function()? onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 30,
        child: Image(image: AssetImage('assets/$icon.png')),
      ),
    );
  }
}

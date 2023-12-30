// ignore_for_file: file_names

import 'package:calculator/Constant.dart';
import 'package:calculator/Page/Calculators/BMI.dart';
import 'package:calculator/Page/Calculators/KDV.dart';
import 'package:calculator/Util/ImageExtension.dart';
import 'package:calculator/Util/PageNavigator.dart';
import 'package:calculator/Util/TextUtility.dart';
import 'package:flutter/material.dart';

import 'Calculators/EMI.dart';
import 'Calculators/LOG.dart';
import 'Calculators/Trigonometry.dart';

class MoreApps extends StatelessWidget {
  MoreApps({super.key});

  final List _moreApp = [
    [ImageEnum.bmi.toPath, moreApps_bmi, const BMI()],
    [ImageEnum.tax.toPath, moreApps_kdv, const KDV()],
    [ImageEnum.hand.toPath, moreApps_faiz, const EMI()],
    [ImageEnum.logarithm.toPath, moreApps_log, LOG()],
    [ImageEnum.trigonometry.toPath, moreApps_tri, Trigonometry()],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          child: GridView.builder(
            itemCount: _moreApp.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 25,
              mainAxisSpacing: 5,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              var item = _moreApp[index];
              return MoreAppTile(
                icon: item[0],
                title: item[1],
                onTap: () => pageNavigator(context, item[2]),
              );
            },
          )),
    );
  }
}

class MoreAppTile extends StatelessWidget {
  const MoreAppTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final String icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
            child: Image(image: AssetImage(icon)),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

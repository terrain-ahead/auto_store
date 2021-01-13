import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:kursach_avto_app/style/style.dart';
Widget buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 100.0,
        width: 100.0,
        child: SpinKitDoubleBounce(
          size: 50,
          color: Style.titleColor,
        ),
      )
    ],
  ));
}

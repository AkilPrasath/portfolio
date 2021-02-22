import 'package:akil_portfolio/homepage.dart';
import 'package:akil_portfolio/page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(1920, 1080),
      allowFontScaling: true,
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StartPage(),
        );
      },
    ),
  );
}

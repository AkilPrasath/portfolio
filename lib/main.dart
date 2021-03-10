import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:akil_portfolio/page1.dart';
import 'package:akil_portfolio/widgets/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(1920, 1080),
      allowFontScaling: true,
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoadingScreen(),
        );
      },
    ),
  );
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
   
  AnimationController controller;
  Animation animation;
   Animatable<Color> bgColor ;
  @override
  void initState() {
    super.initState();
      bgColor = TweenSequence<Color>([
   
  TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(begin: Colors.red, end: Colors.white),
  ),
   
]);
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 750))
      ..addListener(() {
        setState(() {});
        if (controller.isCompleted) {
          controller.reverse();
        }
        if (controller.isDismissed) {
          controller.forward();
        }
      }); 
    animation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      controller.forward();
      await Future.delayed(Duration(seconds:2));
      ByteData bytes = await rootBundle.load("assets/images/akil.jpg");
      Uint8List uint8List = bytes.buffer.asUint8List();
      Map<String,Uint8List> imageMap = {};
      imageMap["akil.jpg"]=uint8List;
      controller.stop();
      Navigator.pushReplacement(context,  ScalePageRoute(child: StartPage(imageMap: imageMap,)));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         
        height: 1.sh,
        width: 1.sw,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
                origin: Offset(0.151.sh, 0.151.sh),
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(animation.value),
                child: Container(
                  height: 0.32.sh,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Image.asset("assets/images/favicon.png"),
                ),
              ),
              Container(
                height: 0.05.sh,
              ),
              Text(
                "Loading assets...",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40.sp,
                  color: bgColor.animate(controller).value,
                ),
              ),
            ],
          ), 
        ),
      ),
    );
  }
}

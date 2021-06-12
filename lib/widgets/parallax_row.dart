import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParallaxRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.6.sh,
      // color: Colors.lime.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ParallaxItem(
            imagePath: "assets/images/website.png",
          ),
          SizedBox(
            width: 50.sp,
          ),
          ParallaxItem(
            imagePath: "assets/images/mobileapp.png",
          ),
          SizedBox(
            width: 50.sp,
          ),
          ParallaxItem(
            imagePath: "assets/images/puzzle.png",
          ),
        ],
      ),
    );
  }
}

class ParallaxItem extends StatefulWidget {
  final String imagePath;
  const ParallaxItem({
    required this.imagePath,
  });

  @override
  _ParallaxItemState createState() => _ParallaxItemState();
}

class _ParallaxItemState extends State<ParallaxItem> {
  bool isHovered = false;
  double dx = 0, dy = 0;
  double cardWidth = 0.25.sw;
  double imageHeight = 0.12.sw;

  @override
  Widget build(BuildContext context) {
    cardWidth = 0.25.sw;
    imageHeight = 0.12.sw;
    return MouseRegion(
      onHover: (details) {
        setState(() {
          dx = (cardWidth * 0.5) - details.localPosition.dx;
          dy = (cardWidth * 0.5) - details.localPosition.dy;
        });
      },
      onEnter: (details) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (details) {
        setState(() {
          isHovered = false;
          dx = 0;
          dy = 0;
        });
      },
      child: Container(
        // child: Transform(    //Commented coz of runtimeError : memory access out of bounds
        // transform: Matrix4.identity()
        //   ..setEntry(3, 2, 0.001)
        //   ..rotateX(0.0015 * dy)
        //   ..rotateY(0.0015 * dx),
        // origin: Offset(cardWidth * 0.5, cardWidth * 0.5),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: cardWidth,
              height: cardWidth,
              decoration: BoxDecoration(
                color: isHovered ? Colors.red : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 0.1,
                  color: Colors.grey,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 70.sp,
                    spreadRadius: 10.sp,
                    offset: Offset(0, 20.sp),
                    color: isHovered ? Colors.red.withOpacity(0.8) : Colors.grey.shade300,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: cardWidth * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: cardWidth * 0.4,
                    ),
                    AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 400),
                      style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w800,
                        color: isHovered ? Colors.white : Colors.blueGrey[800],
                      ),
                      child: Text(
                        "Responsive Web Apps",
                      ),
                    ),
                    SizedBox(
                      height: 0.1 * cardWidth,
                    ),
                    AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 400),
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        color: isHovered ? Colors.white : Colors.blueGrey[800],
                      ),
                      child: Text(
                        "Interactive web apps backed with latest Technology Stack will be built with responsiveness.",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -imageHeight * 0.35 + (dy * 0.1),
              left: cardWidth * 0.125 - (dx * 0.1),
              child: Container(
                height: imageHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Image.asset(
                        widget.imagePath,
                      ),
                    ),
                    Container(
                      width: 90.sp,
                      height: 0.1.sp,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 70.sp,
                            spreadRadius: 5.sp,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParallaxRow extends StatelessWidget {
  const ParallaxRow({
    Key key,
  }) : super(key: key);

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
            imagePath: "assets/images/website.png",
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
    @required this.imagePath,
    Key key,
  }) : super(key: key);

  @override
  _ParallaxItemState createState() => _ParallaxItemState();
}

class _ParallaxItemState extends State<ParallaxItem> {
  bool isHovered;
  double dx, dy;
  double cardWidth = 0.25.sw;
  double imageHeight = 0.12.sw;
  @override
  void initState() {
    super.initState();
    isHovered = false;
    dx = 0;
    dy = 0;
  }

  @override
  Widget build(BuildContext context) {
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
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(0.0015 * dy)
          ..rotateY(0.0015 * dx),
        origin: Offset(cardWidth * 0.5, cardWidth * 0.5),
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
                    blurRadius: 70,
                    spreadRadius: 10,
                    offset: Offset(0, 20.sp),
                    color: isHovered ? Colors.red.withOpacity(0.8) : Colors.grey.shade300,
                  ),
                ],
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
                            blurRadius: 70,
                            spreadRadius: 5,
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

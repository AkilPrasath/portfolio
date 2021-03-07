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
          ParallaxItem(),
          SizedBox(
            width: 50,
          ),
          ParallaxItem(),
          SizedBox(
            width: 50,
          ),
          ParallaxItem(),
        ],
      ),
    );
  }
}

class ParallaxItem extends StatefulWidget {
  const ParallaxItem({
    Key key,
  }) : super(key: key);

  @override
  _ParallaxItemState createState() => _ParallaxItemState();
}

class _ParallaxItemState extends State<ParallaxItem> {
  bool isHovered;
  double dx, dy;
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
          dx = (0.25.sw * 0.5) - details.localPosition.dx;
          dy = (0.25.sw * 0.5) - details.localPosition.dy;
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
        origin: Offset(0.25.sw * 0.5, 0.25.sw * 0.5),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 0.25.sw,
          height: 0.25.sw,
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
      ),
    );
  }
}
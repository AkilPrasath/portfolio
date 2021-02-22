import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

import 'widgets/columnbuilder.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double screenWidth, screenHeight;
  Alignment animatedAlignment = Alignment.centerLeft;
  Color nameColor = Colors.transparent;
  double dividerOpacity = 0;
  double imageOffsetFromLeft = 0;
  //
  double dx = 0, dy = 0;
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.green
  ];
  int containerIndex = -1;
  List<GlobalKey> containerKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey()
  ];
  bool showCursorImage = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void startTitleAnimation() {
    debugPrint("started");
    Future.delayed(Duration(milliseconds: 1)).then((value) {
      setState(() {
        imageOffsetFromLeft = screenWidth * 0.18;
      });
    });
    Future.delayed(Duration(milliseconds: 1)).then((value) {
      setState(() {
        animatedAlignment = Alignment.center;
      });
      Future.delayed(Duration(milliseconds: 450)).then((value) {
        setState(() {
          nameColor = Colors.black;
          dividerOpacity = 1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Positioned(
              left: dx,
              top: dy,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: showCursorImage
                    ? AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 50,
                        width: 50,
                        color: colors[containerIndex],
                      )
                    : Container(),
              ),
            ),
            Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      overflow: Overflow.visible,
                      children: [
                        Align(
                          child: Container(
                            // height: screenHeight * 0.15,
                            width: screenWidth,
                            child: Column(
                              children: [
                                AnimatedAlign(
                                  curve: Curves.elasticInOut,
                                  duration: Duration(milliseconds: 1000),
                                  alignment: animatedAlignment,
                                  child: AnimatedDefaultTextStyle(
                                    duration: Duration(milliseconds: 1000),
                                    style: TextStyle(
                                      fontSize: 85.sp,
                                      color: nameColor,
                                    ),
                                    child: Text(
                                      "I'm Akil Prasath R",
                                    ),
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 1000),
                                  opacity: dividerOpacity,
                                  child: Container(
                                    width: screenWidth * 0.6,
                                    child: Divider(),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 0.3.sw,
                                    ),
                                    Text(
                                      "A Software Engineer destined to make world a better place to live.",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 40.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          curve: Curves.easeIn,
                          duration: Duration(milliseconds: 450),
                          left: imageOffsetFromLeft,
                          child: Container(
                            // height: screenHeight * 0.35,
                            width: screenWidth * 0.15,
                            child: Image.asset(
                              "assets/images/akil.jpg",
                              frameBuilder: (BuildContext context, Widget child,
                                  int frame, bool wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded) {
                                  return child;
                                }
                                if (frame != null) {
                                  startTitleAnimation();
                                }
                                return AnimatedOpacity(
                                  child: child,
                                  opacity: frame == null ? 0 : 1,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeOut,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.2.sh,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Flexible(
                        child: MouseRegion(
                          onEnter: (details) {
                            setState(() {
                              showCursorImage = true;
                            });
                          },
                          onExit: (details) {
                            setState(() {
                              showCursorImage = false;
                              containerIndex = -1;
                            });
                          },
                          child: ColumnBuilder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return MouseRegion(
                                onHover: (PointerHoverEvent event) {
                                  setState(() {
                                    RenderBox box = containerKeys[index]
                                        .currentContext
                                        .findRenderObject() as RenderBox;
                                    Offset off =
                                        box.localToGlobal(event.localPosition);
                                    dy = off.dy - 25;
                                    dx = off.dx - 25;
                                    containerIndex = index;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 0.6.sw,
                                  key: containerKeys[index],
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: AnimatedDefaultTextStyle(
                                        duration: Duration(milliseconds: 300),
                                        style: TextStyle(
                                          fontSize: containerIndex == index
                                              ? 35.sp
                                              : 30.sp,
                                        ),
                                        child: Text("Achievement $index")),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

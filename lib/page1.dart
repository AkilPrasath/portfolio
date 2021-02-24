import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

import 'widgets/columnbuilder.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  double screenWidth, screenHeight;

  //
  double dx = 0, dy = 0;
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.green,
  ];
  int containerIndex = -1;
  List<GlobalKey> containerKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  int cardIndex = 0;
  List<String> titleList = [
    "Title 1",
    "Title 2",
    "Title 3",
  ];
  List<String> contentList = [
    "Sed tincidunt nec dolor ac pretium. In venenatis faucibus dignissim. Nullam consectetur tincidunt sapien. Aenean eu molestie tellus. Nunc nec fermentum libero.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean eu molestie tellus. Nunc nec fermentum libero.",
    "Nullam consectetur tincidunt sapien. Aenean eu molestie tellus. Nunc nec fermentum libero.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt nec dolor ac pretium. In venenatis faucibus dignissim.",
  ];
  bool showCursorImage = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 4), start);
  }

  void start(Timer timer) {
    setState(() {
      cardIndex = (cardIndex + 1) % 3;
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
                        color: containerIndex != -1 ? colors[containerIndex] : Colors.transparent,
                      )
                    : Container(),
              ),
            ),
            Container(
              height: screenHeight,
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    TitleRow(),
                    SizedBox(
                      height: 0.1.sh,
                    ),
                    Flexible(
                      child: Container(
                        height: 0.4.sh,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 18.sp,
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    height: 10.sp,
                                    width: 10.sp,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: cardIndex == 0
                                          ? Colors.grey.withOpacity(0.8)
                                          : Colors.grey.withOpacity(0.2),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      height: 10.sp,
                                      width: 10.sp,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: cardIndex == 1
                                            ? Colors.grey.withOpacity(0.8)
                                            : Colors.grey.withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    height: 10.sp,
                                    width: 10.sp,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: cardIndex == 2
                                          ? Colors.grey.withOpacity(0.8)
                                          : Colors.grey.withOpacity(0.2),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.2.sh,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.instagram,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  SizedBox(
                                    height: 18.sp,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.linkedinIn,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30.sp,
                            ),
                            Flexible(
                              child: AnimatedSwitcher(
                                transitionBuilder: (Widget child, Animation<double> animation) {
                                  final offsetAnimation = Tween<Offset>(
                                          end: Offset(-0.05, 0.0), begin: Offset(-0.1, 0.0))
                                      .animate(animation);
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    ),
                                  );
                                },
                                duration: Duration(seconds: 1),
                                child: Container(
                                  key: Key(cardIndex.toString()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          titleList[cardIndex],
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 60.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50.sp,
                                        ),
                                        Flexible(
                                          child: Text(
                                            contentList[cardIndex],
                                            style: TextStyle(
                                              // color: Colors.red,
                                              fontSize: 25.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 0.4.sw,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                        Offset off = box.localToGlobal(event.localPosition);
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
                                        padding: const EdgeInsets.all(24.0),
                                        child: AnimatedDefaultTextStyle(
                                            duration: Duration(milliseconds: 300),
                                            style: TextStyle(
                                              fontSize: containerIndex == index ? 35.sp : 30.sp,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleRow extends StatefulWidget {
  @override
  _TitleRowState createState() => _TitleRowState();
}

class _TitleRowState extends State<TitleRow> with TickerProviderStateMixin {
  AnimationController imageOffsetAnimationController, textOffsetAnimationController;
  Animation<Offset> imageOffsetAnimation, textOffsetAnimation;
  bool imageLoaded = false;
  Color nameColor = Colors.transparent;
  Color sidelineColor = Colors.transparent;
  double subtitleOpacity = 0;
  double imageOffsetFromLeft = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageOffsetAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    textOffsetAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    imageOffsetAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.3, 0))
        .animate(CurvedAnimation(parent: imageOffsetAnimationController, curve: Curves.ease));
    textOffsetAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.3, 0))
        .animate(CurvedAnimation(parent: textOffsetAnimationController, curve: Curves.ease));
  }

  @override
  void dispose() {
    textOffsetAnimationController.dispose();
    imageOffsetAnimationController.dispose();
    super.dispose();
  }

  void startTitleAnimation() async {
    imageOffsetAnimationController.forward();
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      textOffsetAnimationController.forward();
    });
    await Future.delayed(Duration(milliseconds: 475)).then((value) {
      setState(() {
        nameColor = Colors.black;
        sidelineColor = Colors.pink[500];
      });
    });
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      setState(() {
        subtitleOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Stack(
            alignment: Alignment.centerLeft,
            overflow: Overflow.visible,
            children: [
              Container(
                width: 1.sw,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SlideTransition(
                        position: textOffsetAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 1000),
                              style: TextStyle(
                                fontSize: 85.sp,
                                color: nameColor,
                                fontWeight: FontWeight.w800,
                              ),
                              child: Text(
                                "Akil Prasath",
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 1000),
                                    height: 5.sp,
                                    width: 0.55.sw,
                                    color: sidelineColor,
                                  ),
                                ),
                                AnimatedDefaultTextStyle(
                                  duration: Duration(milliseconds: 1000),
                                  style: TextStyle(
                                    fontSize: 85.sp,
                                    color: nameColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  child: Text(
                                    "R",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 0.1.sw,
                          ),
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 1200),
                            opacity: subtitleOpacity,
                            child: Text(
                              "I create Apps and Websites.",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                                fontSize: 40.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SlideTransition(
                position: Tween<Offset>(begin: Offset(0, 0), end: Offset(1, 0)).animate(
                    CurvedAnimation(parent: imageOffsetAnimationController, curve: Curves.ease)),
                child: Container(
                  width: 0.15.sw,
                  child: Image.asset(
                    "assets/images/akil.jpg",
                    key: Key("image"),
                    frameBuilder: (BuildContext context, Widget child, int frame,
                        bool wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      if (frame != null && !imageLoaded) {
                        startTitleAnimation();
                        imageLoaded = true;
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
        ),
      ],
    );
  }
}

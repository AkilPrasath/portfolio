import 'dart:async';
import 'package:akil_portfolio/widgets/rowbuilder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'widgets/columnbuilder.dart';
import 'widgets/parallax_row.dart';
import 'widgets/title_row.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  double screenWidth = 0, screenHeight = 0;

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
  int menuHoverIndex = -1;
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
    super.initState();
    Timer.periodic(Duration(seconds: 5), startCarousel);
  }

  void startCarousel(Timer timer) {
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
                        height: 100,
                        width: 200,
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
                    SizedBox(height: 0.02.sh),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: RowBuilder(
                        mainAxisAlignment: MainAxisAlignment.center,
                        itemCount: 4,
                        itemBuilder: (context, int index) {
                          return menuHeadingItem(index);
                        },
                      ),
                    ),
                    SizedBox(height: 0.03.sh),
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
                                  carouselIndicator(0),
                                  carouselIndicator(1),
                                  carouselIndicator(2),
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
                              width: 16.sp,
                            ),
                            Flexible(
                              child: AnimatedSwitcher(
                                transitionBuilder: (Widget child, Animation<double> animation) {
                                  final offsetAnimation =
                                      Tween<Offset>(begin: Offset(-0.2, 0.0), end: Offset(0.0, 0.0))
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
                                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
                            SizedBox(width: 0.1.sw),
                            Container(
                              width: 0.4.sw,
                              child: Lottie.asset("assets/lotties/scrolling_lottie.json"),
                              // child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 0.4.sw),
                      child: Divider(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 0.12.sw,
                          ),
                          Text(
                            "Events and \nAccomplishments",
                            style: subHeadingStyle(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.05.sh,
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
                                    onHover: (event) {
                                      setState(() {
                                        RenderBox box = containerKeys[index]
                                            .currentContext
                                            .findRenderObject() as RenderBox;
                                        Offset off = box.localToGlobal(event.localPosition);
                                        dy = off.dy - 50;
                                        dx = off.dx - 100;
                                        containerIndex = index;
                                      });
                                    },
                                    child: Container(
                                      // color: Colors.purple.withOpacity(0.2),
                                      alignment: Alignment.center,
                                      width: 0.76.sw,
                                      key: containerKeys[index],
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: AnimatedDefaultTextStyle(
                                              duration: Duration(milliseconds: 300),
                                              style: TextStyle(
                                                fontSize: containerIndex == index ? 35.sp : 30.sp,
                                              ),
                                              child: Text("Achievement $index"),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: AnimatedSwitcher(
                                                duration: Duration(milliseconds: 300),
                                                child: containerIndex != index
                                                    ? Container(
                                                        key: ValueKey("$index  "),
                                                        height: 100,
                                                        width: 100,
                                                        color: colors[index],
                                                      )
                                                    : Container(
                                                        key: UniqueKey(),
                                                        height: 100,
                                                        width: 100,
                                                        color: Colors.transparent,
                                                      )),
                                          ),
                                        ],
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
                    SizedBox(
                      height: 0.05.sh,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 0.12.sw,
                          ),
                          Text(
                            "Services",
                            style: subHeadingStyle(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.1.sh,
                    ),
                    ParallaxRow(),
                    Container(
                      height: 1000,
                      color: Colors.transparent,
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

  TextStyle subHeadingStyle() {
    return TextStyle(
      fontSize: 50.sp,
      fontWeight: FontWeight.w700,
      color: Colors.blue,
    );
  }

  Padding carouselIndicator(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: 10.sp,
        width: 10.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cardIndex == index ? Colors.grey.withOpacity(0.8) : Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }

  Row menuHeadingItem(int index) {
    return Row(
      children: [
        SizedBox(
          width: 0.05.sw,
        ),
        MouseRegion(
          onEnter: (details) {
            setState(() {
              menuHoverIndex = index;
            });
          },
          onExit: (details) {
            setState(() {
              menuHoverIndex = -1;
            });
          },
          child: AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 250),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: menuHoverIndex == index ? 25.sp : 24.sp,
              color: menuHoverIndex == index ? Colors.red : Colors.grey[600],
            ),
            child: Text(
              "Heading $index",
            ),
          ),
        ),
        SizedBox(
          width: 0.05.sw,
        ),
      ],
    );
  }
}

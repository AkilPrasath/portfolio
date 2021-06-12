import 'dart:async';

import 'dart:typed_data';
import 'package:akil_portfolio/widgets/rowbuilder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'widgets/columnbuilder.dart';
import 'widgets/parallax_row.dart';
import 'widgets/title_row.dart';

class StartPage extends StatefulWidget {
  final Map<String, Uint8List> imageMap;
  StartPage({required this.imageMap});
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  double screenWidth = 0, screenHeight = 0;

  //
  double dx = 0, dy = 0;

  int containerIndex = -1;
  int menuHoverIndex = -1;
  List<GlobalKey> containerKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  List<String> galleryHeadings = [
    "Smart India Hackathon - 2019",
    "Chhtra Vishwakarma Award - AICTE",
    "Hack Off - VIT",
    "Computer Vision Workshop - IIT Madras",
    "Machine Learning Workshop - KCT Tech Park",
  ];
  bool instagramHovered = false;
  bool linkedinHovered = false;
  int cardIndex = 0;
  List<String> titleList = [
    "I am resourceful",
    "I develop",
    "I am\nCommitted",
  ];
  List<String> contentList = [
    "software developer who is confident in data structures.",
    "mobile applications and also APIs.",
    "to lifelong learning and believes in teamwork and dedication.",
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
                        alignment: Alignment.bottomCenter,
                        key: Key(containerIndex.toString()),
                        duration: Duration(milliseconds: 300),
                        height: 400.sp,
                        width: 600.sp,
                        // color: containerIndex != -1 ? colors[containerIndex] : Colors.transparent,
                        child: containerIndex != -1
                            ? Image.memory(
                                widget.imageMap["$containerIndex.jpg"] ?? Uint8List.fromList([]),
                                fit: BoxFit.fitHeight,
                              )
                            : SizedBox(),
                      )
                    : Container(
                        key: UniqueKey(),
                      ),
              ),
            ),
            Container(
              height: screenHeight,
              width: screenWidth,
              child: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: RowBuilder(
                          mainAxisAlignment: MainAxisAlignment.end,
                          itemCount: 4,
                          itemBuilder: (context, int index) {
                            return menuHeadingItem(index);
                          },
                        ),
                      ),

                      TitleRow(),
                      SizedBox(
                        height: 0.1.sh,
                      ),
                      //Splits side bar and main content
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 7,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0.05.sw),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 0.4.sh,
                                      // color: Colors.blue,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
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
                                                HoverableIcon(
                                                  hoverColor: Color(0xffE5495F),
                                                  icon: FontAwesomeIcons.instagram,
                                                  isHovered: instagramHovered,
                                                  onEnter: (d) {
                                                    setState(() {
                                                      instagramHovered = true;
                                                    });
                                                  },
                                                  onExit: (d) {
                                                    setState(() {
                                                      instagramHovered = false;
                                                    });
                                                  },
                                                  onTap: () async {
                                                    String instaURL =
                                                        "https://www.instagram.com/akilspacestark_";
                                                    await canLaunch(instaURL)
                                                        ? launch(instaURL)
                                                        : print("error opening url");
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 18.sp,
                                                ),
                                                HoverableIcon(
                                                  hoverColor: Color(0xff0073B1),
                                                  icon: FontAwesomeIcons.linkedinIn,
                                                  isHovered: linkedinHovered,
                                                  onEnter: (d) {
                                                    setState(() {
                                                      linkedinHovered = true;
                                                    });
                                                  },
                                                  onExit: (d) {
                                                    setState(() {
                                                      linkedinHovered = false;
                                                    });
                                                  },
                                                  onTap: () async {
                                                    String linkedinURL =
                                                        "https://www.linkedin.com/in/akilprasathr/";
                                                    await canLaunch(linkedinURL)
                                                        ? launch(linkedinURL)
                                                        : print("error opening url");
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: AnimatedSwitcher(
                                              transitionBuilder:
                                                  (Widget child, Animation<double> animation) {
                                                final offsetAnimation = Tween<Offset>(
                                                  begin: Offset(-0.2, 0.0),
                                                  end: Offset(0.0, 0.0),
                                                ).animate(animation);
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
                                                  padding:
                                                      const EdgeInsets.symmetric(horizontal: 32.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      FittedBox(
                                                        child: Text(
                                                          titleList[cardIndex],
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 60.sp,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20.sp,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          contentList[cardIndex],
                                                          style: TextStyle(
                                                            // color: Colors.red,
                                                            fontSize: 39.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Lottie.asset(
                                                "assets/lotties/developer_lottie.json"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 0.01.sh),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
                                    child: Divider(),
                                  ),
                                  SizedBox(height: 0.01.sh),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Event Gallery",
                                        style: subHeadingStyle(),
                                      ),
                                      SizedBox(
                                        height: 0.05.sh,
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            MouseRegion(
                                              cursor: SystemMouseCursors.none,
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
                                                            ?.findRenderObject() as RenderBox;
                                                        Offset off =
                                                            box.localToGlobal(event.localPosition);
                                                        dx = off.dx - 200;
                                                        dy = off.dy - 200;
                                                        containerIndex = index;
                                                      });
                                                    },
                                                    child: Container(
                                                      // color: Colors.purple.withOpacity(0.2),

                                                      alignment: Alignment.center,
                                                      // width: 1.sw,
                                                      key: containerKeys[index],
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          AnimatedDefaultTextStyle(
                                                            duration: Duration(milliseconds: 300),
                                                            style: TextStyle(
                                                              fontSize: containerIndex == index
                                                                  ? 35.sp
                                                                  : 30.sp,
                                                              fontWeight: containerIndex == index
                                                                  ? FontWeight.w800
                                                                  : FontWeight.w600,
                                                              color: containerIndex == index
                                                                  ? Colors.blueGrey[900]
                                                                  : Colors.blueGrey[700],
                                                            ),
                                                            child: Text(galleryHeadings[index]),
                                                          ),
                                                          // Spacer(),

                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: AnimatedSwitcher(
                                                                duration:
                                                                    Duration(milliseconds: 300),
                                                                child: containerIndex != index
                                                                    ? Container(
                                                                        key: ValueKey("$index  "),
                                                                        height: 150.sp,
                                                                        width: 300.sp,
                                                                        child: Image.memory(
                                                                          widget.imageMap[
                                                                                  "$index.jpg"] ??
                                                                              Uint8List.fromList(
                                                                                  []),
                                                                          fit: BoxFit.fitWidth,
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        key: UniqueKey(),
                                                                        height: 150.sp,
                                                                        width: 300.sp,
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 0.2.sh,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.sp),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 0.05.sw),
                              child: Text(
                                "Services",
                                style: subHeadingStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 0.1.sh,
                            ),
                            ParallaxRow(),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Color(0xffE5495F) insta
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

class HoverableIcon extends StatelessWidget {
  bool isHovered;
  Color hoverColor;
  IconData icon;
  Function(PointerEnterEvent) onEnter;
  Function(PointerExitEvent) onExit;
  Function() onTap;
  HoverableIcon({
    required this.onEnter,
    required this.onExit,
    required this.onTap,
    required this.isHovered,
    required this.hoverColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: InkWell(
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onTap,
        child: FaIcon(
          icon,
          color: isHovered ? hoverColor : Colors.grey.withOpacity(0.3),
        ),
      ),
    );
  }
}

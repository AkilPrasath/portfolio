import 'dart:async';

import 'dart:typed_data';
import 'dart:ui';
import 'package:akil_portfolio/data/constants.dart';

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

  int cardIndex = 0;
  bool showCursorImage = false;
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.blue.shade50,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            menuHeadingItem("Home", 0),
                            menuHeadingItem("Education", 1),
                            menuHeadingItem("Achievements", 2),
                            menuHeadingItem("Contact", 3),
                          ],
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
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 4,
                                            child: CarouselItem(
                                              imageMap: widget.imageMap,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
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
                                                    child: AnimatedContainer(
                                                      duration: Duration(milliseconds: 300),
                                                      color: Colors.transparent,

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
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  10),
                                                                          border: Border.all(
                                                                            color: primaryColor,
                                                                            width: 2,
                                                                          ),
                                                                        ),
                                                                        child: ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  10),
                                                                          child: Image.memory(
                                                                            widget.imageMap[
                                                                                    "$index.jpg"] ??
                                                                                Uint8List.fromList(
                                                                                    []),
                                                                            fit: BoxFit.fitWidth,
                                                                          ),
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
                            child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
                              return Container(
                                padding: EdgeInsets.all(4),
                                width: constraints.maxWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AreaOfExpertise(
                                      width: constraints.maxWidth,
                                    ),
                                  ],
                                ),
                              );
                            }),
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
      color: primaryColor,
    );
  }

  Row menuHeadingItem(String title, int index) {
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
              fontWeight: (menuHoverIndex == index || selectedPage == index)
                  ? FontWeight.w900
                  : FontWeight.w600,
              // fontSize: menuHoverIndex == index ? 25.sp : 24.sp,
              fontSize: 24.sp,
              color: (menuHoverIndex == index || selectedPage == index)
                  ? primaryColor
                  : Colors.grey[600],
            ),
            child: Text(
              "$title",
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

class CarouselItem extends StatefulWidget {
  final Map<String, Uint8List> imageMap;
  CarouselItem({required this.imageMap});
  @override
  _CarouselItemState createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  int cardIndex = 0;

  List<String> carouselList = [
    "pair program",
    "time",
    "team work",
    "coffee",
  ];

  List<String> carouselContentsList = [
    "Pair Programmer",
    "Value Time",
    "Team Player",
    "Of course I Love Coffee <3",
  ];
  bool isHovered = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        Timer.periodic(Duration(seconds: 5), startCarousel);
      });
    });
  }

  void startCarousel(Timer timer) {
    if (!isHovered)
      setState(() {
        cardIndex = (cardIndex + 1) % carouselContentsList.length;
      });
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
          color: cardIndex == index ? Colors.grey.withOpacity(0.9) : Colors.grey.withOpacity(0.3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 18.sp,
            ),
            carouselIndicator(0),
            carouselIndicator(1),
            carouselIndicator(2),
            carouselIndicator(3),
          ],
        ),
        SizedBox(
          width: 0.01.sw,
        ),
        Expanded(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return MouseRegion(
              onEnter: (event) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (event) {
                setState(() {
                  isHovered = false;
                });
              },
              child: Container(
                height: constraints.maxWidth,
                // padding: EdgeInsets.symmetric(
                //     vertical: 24.sp, horizontal: 32.sp),
                decoration: BoxDecoration(
                  // color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: AnimatedSwitcher(
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: Offset(0.0, 0.2),
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
                    child: Stack(
                      children: [
                        Container(
                          height: constraints.maxWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.memory(
                              widget.imageMap[carouselList[cardIndex] + ".jpg"] ??
                                  Uint8List.fromList([]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black26,
                          ),
                          height: constraints.maxWidth,
                          width: constraints.maxWidth,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: Colors.white30,
                                height: constraints.maxWidth * 0.10,
                                width: constraints.maxWidth,
                                alignment: Alignment.center,
                                child: Text(
                                  carouselContentsList[cardIndex],
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxWidth * 0.10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class AreaOfExpertise extends StatelessWidget {
  const AreaOfExpertise({
    Key? key,
    required this.width,
  }) : super(key: key);
  final double width;
  final List<String> techList = const [
    "C",
    "Dart",
    "Firebase",
    "Flutter",
    "Git",
    "Github",
    "Api",
    "Web",
    "Java",
    "Mongodb",
    "Mysql",
    "Nodejs",
    "Python",
    "Raspberrypi",
  ];
  final List<String> whatIDoList = const [
    "Solve problems for competitive programming contests and also for fun.",
    "Develop responsive web and mobile applications for freelance.",
    "Build and integrate secure APIs with applications.",
    "Design SQL as well as NoSQL databases (local/cloud) for applications.",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 32.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primaryColor,
      ),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "My Area of Expertise",
            style: TextStyle(
              color: accentColor,
              fontSize: 45.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 0.03.sh,
          ),
          Wrap(
            children: List.generate(
              techList.length,
              (index) {
                return TechItem(techName: techList[index]);
              },
            ),
          ),
          SizedBox(
            height: 0.03.sh,
          ),
          Text(
            "What I do ?",
            style: TextStyle(
              color: accentColor,
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 0.015.sh,
          ),
          ColumnBuilder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: Text(
                  whatIDoList[index],
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              );
            },
            itemCount: whatIDoList.length,
          ),
        ],
      ),
    );
  }
}

class TechItem extends StatelessWidget {
  const TechItem({
    Key? key,
    required this.techName,
  }) : super(key: key);

  final String techName;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: false,
      padding: EdgeInsets.all(6.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      textStyle: TextStyle(
        color: primaryColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      height: 20.sp,
      message: "$techName",
      child: Container(
        width: 80.sp,
        padding: EdgeInsets.all(6.sp),
        child: Image.asset(
          "assets/images/tech/$techName.png",
          // color: primaryColor.withOpacity(0.4),
          // colorBlendMode: BlendMode.modulate,
        ),
      ),
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
          color: hoverColor,
          size: 40.sp,
        ),
      ),
    );
  }
}

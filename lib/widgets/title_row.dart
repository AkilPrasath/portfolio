import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleRow extends StatefulWidget {
  @override
  _TitleRowState createState() => _TitleRowState();
}

class _TitleRowState extends State<TitleRow> with TickerProviderStateMixin {
  late AnimationController imageOffsetAnimationController, textOffsetAnimationController;
  late Animation<Offset> imageOffsetAnimation, textOffsetAnimation;
  bool imageLoaded = false;
  Color nameColor = Colors.transparent;
  Color sidelineColor = Colors.transparent;
  double subtitleOpacity = 0;
  double imageOffsetFromLeft = 0;
  bool showTypeWriterText = false;
  @override
  void initState() {
    super.initState();
    imageOffsetAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    textOffsetAnimationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    textOffsetAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.35, 0))
        .animate(CurvedAnimation(parent: textOffsetAnimationController, curve: Curves.ease));
    textOffsetAnimation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showTypeWriterText = true;
        });
      }
    });
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
        sidelineColor = Colors.pink.shade500;
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
            clipBehavior: Clip.none,
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
                    // AnimatedOpacity(
                    //   duration: Duration(milliseconds: 1200),
                    //   opacity: subtitleOpacity,
                    //   child: Container(
                    //     color: Colors.blue,
                    //     child: Row(
                    //       children: [
                    //         SizedBox(width: 0.26.sw),
                    //         Container(
                    //           width: 0.6.sw,
                    //           decoration: BoxDecoration(
                    //             color: Colors.blue,
                    //             borderRadius: BorderRadius.circular(15),
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 Text(
                    //                   "A resourceful software developer who is confident in data structures.",
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 25.sp,
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   " Involved in the development of mobile applications and integration of API.",
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 25.sp,
                    //                   ),
                    //                 ),
                    //                 Text(
                    //                   " Committed to lifelong learning and believes in teamwork and dedication.",
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 25.sp,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 25.sp),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 100),
                      child: showTypeWriterText
                          ? AnimatedTextKit(
                              isRepeatingAnimation: false,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  "I create Apps and Websites. ",
                                  textStyle: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 45.sp,
                                  ),
                                  speed: Duration(milliseconds: 75),
                                ),
                              ],
                            )
                          : Text(""),
                    ),
                    // Flexible(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SizedBox(
                    //         width: 0.1.sw,
                    //       ),
                    //       AnimatedOpacity(
                    //         duration: Duration(milliseconds: 1200),
                    //         opacity: subtitleOpacity,
                    //         child: Text(
                    //           "I create Apps and Websites.",
                    //           style: TextStyle(
                    //             color: Colors.blue,
                    //             fontWeight: FontWeight.w700,
                    //             fontSize: 40.sp,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SlideTransition(
                position: Tween<Offset>(begin: Offset(0, 0), end: Offset(0.7, 0)).animate(
                  CurvedAnimation(parent: imageOffsetAnimationController, curve: Curves.ease),
                ),
                child: ClipOval(
                  child: Container(
                    width: 0.15.sw,
                    child: Image.asset(
                      "assets/images/akil.jpg",
                      key: Key("image"),
                      frameBuilder: (BuildContext context, Widget child, int? frame,
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}

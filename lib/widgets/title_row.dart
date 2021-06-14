import 'package:akil_portfolio/data/constants.dart';
import 'package:akil_portfolio/page1.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TitleRow extends StatefulWidget {
  @override
  _TitleRowState createState() => _TitleRowState();
}

class _TitleRowState extends State<TitleRow> with TickerProviderStateMixin {
  late AnimationController imageOffsetAnimationController, textOffsetAnimationController;
  late Animation<Offset> imageOffsetAnimation, textOffsetAnimation;
  bool imageLoaded = false;
  Color nameColor = Colors.black;
  double opacity = 0;
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
        opacity = 1;
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
                        child: AnimatedOpacity(
                          opacity: opacity,
                          duration: Duration(milliseconds: 400),
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 1000),
                                          height: 5.sp,
                                          width: 0.55.sw,
                                          color: primaryColor,
                                        ),
                                        SizedBox(height: 12.sp),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            HoverableIcon(
                                              onEnter: (event) {},
                                              onExit: (event) {},
                                              onTap: () {
                                                canLaunch(instagramURL).then((canLaunch) {
                                                  if (canLaunch) launch(instagramURL);
                                                });
                                              },
                                              isHovered: true,
                                              hoverColor: Color(0xffE4326F),
                                              icon: FontAwesomeIcons.instagram,
                                            ),
                                            SizedBox(
                                              width: 24.sp,
                                            ),
                                            HoverableIcon(
                                              onEnter: (event) {},
                                              onExit: (event) {},
                                              onTap: () {
                                                canLaunch(facebookURL).then((canLaunch) {
                                                  if (canLaunch) launch(facebookURL);
                                                });
                                              },
                                              isHovered: true,
                                              hoverColor: Color(0xff3b5998),
                                              icon: FontAwesomeIcons.facebook,
                                            ),
                                            SizedBox(
                                              width: 24.sp,
                                            ),
                                            HoverableIcon(
                                              onEnter: (event) {},
                                              onExit: (event) {},
                                              onTap: () {
                                                canLaunch(whatsAppURL).then((canLaunch) {
                                                  if (canLaunch) launch(whatsAppURL);
                                                });
                                              },
                                              isHovered: true,
                                              hoverColor: Color(0xff47C357),
                                              icon: FontAwesomeIcons.whatsapp,
                                            ),
                                            SizedBox(
                                              width: 24.sp,
                                            ),
                                            HoverableIcon(
                                              onEnter: (event) {},
                                              onExit: (event) {},
                                              onTap: () {
                                                canLaunch(mailURL).then((canLaunch) {
                                                  if (canLaunch) launch(mailURL);
                                                });
                                              },
                                              isHovered: true,
                                              hoverColor: Color(0xffE94134),
                                              icon: FontAwesomeIcons.envelope,
                                            ),
                                            SizedBox(
                                              width: 24.sp,
                                            ),
                                            HoverableIcon(
                                              onEnter: (event) {},
                                              onExit: (event) {},
                                              onTap: () {
                                                canLaunch(githubURL).then((canLaunch) {
                                                  if (canLaunch) launch(githubURL);
                                                });
                                              },
                                              isHovered: true,
                                              hoverColor: Color(0xff211f1f),
                                              icon: FontAwesomeIcons.github,
                                            ),
                                            SizedBox(
                                              width: 24.sp,
                                            ),
                                            HoverableIcon(
                                              onEnter: (event) {},
                                              onExit: (event) {},
                                              onTap: () {
                                                canLaunch(linkedinURL).then((canLaunch) {
                                                  if (canLaunch) launch(linkedinURL);
                                                });
                                              },
                                              isHovered: true,
                                              hoverColor: Color(0xff0077b5),
                                              icon: FontAwesomeIcons.linkedin,
                                            ),
                                          ],
                                        ),
                                      ],
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
                    ),
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
                                    color: primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 45.sp,
                                  ),
                                  speed: Duration(milliseconds: 75),
                                ),
                              ],
                            )
                          : Text(""),
                    ),
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

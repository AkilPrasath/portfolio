import 'package:flutter/cupertino.dart';

class ScalePageRoute extends PageRouteBuilder {
  Widget child;
  ScalePageRoute({@required this.child})
      : super(
          pageBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
            return child;
          },
          transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secAnimation, Widget child) {
            return ScaleTransition(
              scale: Tween<double>(end: 1,begin: 2).animate(animation),
              child: Opacity(opacity: animation.value, child: child));
          },
          transitionDuration: Duration(seconds: 1),
          reverseTransitionDuration: Duration(seconds: 1),
        );
}

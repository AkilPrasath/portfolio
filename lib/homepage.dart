import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/columnbuilder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dx = 0, dy = 0;
  List<Color> colors = [Colors.red, Colors.blue, Colors.purple, Colors.orange, Colors.green];
  int containerIndex = 0;
  List<GlobalKey> containerKeys = [GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey(), GlobalKey()];
  bool showCursorImage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                                  ?.findRenderObject() as RenderBox;
                              Offset off = box.localToGlobal(event.localPosition);
                              dy = off.dy - 25;
                              dx = off.dx - 25;
                              containerIndex = index;
                            });
                          },
                          child: Container(
                            key: containerKeys[index],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Hello $index"),
                            ),
                          ),
                        );
                      },
                    ),
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

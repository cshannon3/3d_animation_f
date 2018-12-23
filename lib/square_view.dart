import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v;
import 'square_model.dart';

class SquareView extends StatefulWidget {
  final SquareModel cb;

  const SquareView({Key key, @required this.cb}) : super(key: key);

  @override
  _SquareViewState createState() => _SquareViewState();
}

class _SquareViewState extends State<SquareView> with TickerProviderStateMixin {
  SquareModel cb;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    cb = widget.cb;
    cb.init();
    //b.rotateAroundDown(50.0);
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..addListener(() {
            setState(() {
              cb.rotateAroundDown(400.0 * animationController.value);
            });
          })
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(cb.pointOfRotation.right,
              cb.pointOfRotation.down, cb.pointOfRotation.out),
          child: FractionalTranslation(
            translation: Offset(-0.5, -0.5),
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(),
        )
      ]..addAll(cb.getPoints().map((pt) {
          return Transform(
            transform: Matrix4.translationValues(
              pt.right,
              pt.down,
              pt.out,
            ),
            child: FractionalTranslation(
              translation: Offset(-0.5, -0.5),
              child: Opacity(
                opacity: (pt.out < -120.0) ? 0.3 : 1.0,
                child: Container(
                  height: 20.0 + (200 + pt.out) / 10.0,
                  width: 20.0 + (200 + pt.out) / 10.0,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black)),
                  child: Text(
                      "${(pt.right).floor()} ${(pt.down).floor()} ${(pt.out).floor()}"),
                ),
              ),
            ),
          );
        })),
    );
  }
}

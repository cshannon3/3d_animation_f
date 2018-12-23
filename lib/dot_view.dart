import 'dart:math';
import 'package:flutter/material.dart';
import 'package:folding_cells_f/dot_model.dart';
import 'package:folding_cells_f/trig.dart';
import 'package:vector_math/vector_math_64.dart' as v;
import 'square_model.dart';

class DotView extends StatefulWidget {
  final DotModel cb;

  const DotView({Key key, @required this.cb}) : super(key: key);

  @override
  _DotViewState createState() => _DotViewState();
}

class _DotViewState extends State<DotView> with TickerProviderStateMixin {
  DotModel cb;
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
              cb.rotateAroundOut(400.0 * animationController.value);
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
          child: CustomPaint(
            painter: ActivationPainter(
              radius: cb.getOutRadius(0),
              r2: cb.radius,
              r3: cb.getOutRadius(4),
              r3out: cb.getPoint(4).out,
              thickness: 5.0,
              roatation: 400.0 * animationController.value,
              color: Colors.pink,
            ),
            child: FractionalTranslation(
              translation: Offset(-0.5, -0.5),
              child: Container(
                height: 5.0,
                width: 5.0,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        /*Transform(
          transform: Matrix4.translationValues(cb.pointOfRotation.right,
              cb.pointOfRotation.down, cb.pointOfRotation.out)
            ..rotateX(rad(50.0))
            ..rotateY(rad(50.0)),
          child: FractionalTranslation(
            translation: Offset(-0.5, -0.5),
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),*/
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
              child: Container(
                height: 20.0 + (200 + pt.out) / 10.0,
                width: 20.0 + (200 + pt.out) / 10.0,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                //  child: Text("${(pt.right - cb.pointOfRotation.right).floor()} ${(pt.down - cb.pointOfRotation.down).floor()} ${(pt.out - cb.pointOfRotation.out).floor()}"),
              ),
            ),
          );
        })),
    );
  }
}

class PolyPainter extends CustomPainter {
  Pointrdo3d point;
  final double radius;

  PolyPainter({this.point, this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // int sides = 5;
    Paint p = Paint()..color.blue;

    //final path = Path();
    //path.moveTo(finalwidth / 2, finalwidth / 2);
    //Point lastPoint = Point(finalwidth / 2, finalwidth / 2);

    canvas.drawCircle(Offset(0.0, 0.0), radius, p);

    //canvas.transform(Matrix4.translationValues(-sidelen / 2, -maxheight / 2, 0.0));

    // final paintHeight = size.height - finalbottom;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class ActivationPainter extends CustomPainter {
  final double radius;
  final double r2;
  final double r3;
  final double r3out;
  final double thickness;
  final Color color;
  final double roatation;
  final Paint activationPaint;
  final Paint activationPaint2;
  final Paint activationPaint3;

  ActivationPainter({
    this.radius,
    this.r2,
    this.r3,
    this.roatation,
    this.r3out,
    this.thickness,
    this.color,
  })  : activationPaint = new Paint()
          ..color = color
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
        activationPaint2 = new Paint()
          ..color = Colors.green
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
        activationPaint3 = new Paint()
          ..color = Colors.blue
          ..strokeWidth = thickness
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromLTWH(
        -radius,
        -radius,
        radius * 2,
        radius * 2,
      ),
      rad(0.0),
      rad(400.0), //sweepAngle,
      false, //useCenter,
      activationPaint,
    );

    canvas.drawArc(
      Rect.fromLTWH(
        -r2,
        -r2,
        r2 * 2,
        r2 * 2,
      ),
      rad(0.0),
      rad(400.0), //sweepAngle,
      false, //useCenter,
      activationPaint2,
    );
    canvas.drawOval(
      Rect.fromLTRB(
        -r3,
        -r3 + r3 * (Z(roatation) / 2),
        r3, //*((r3out).abs() / (r3)),
        r3 - r3 * (Z(roatation) / 2),
      ),
      activationPaint3,
    );
    // canvas.rotate(rad(250.0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

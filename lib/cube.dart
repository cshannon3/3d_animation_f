import 'dart:math';
import 'package:flutter/material.dart';
import 'cube_model.dart';

class Cube extends StatefulWidget {
  final CubeModel cb;

  const Cube({Key key, @required this.cb}) : super(key: key);

  @override
  _CubeState createState() => _CubeState();
}

class _CubeState extends State<Cube> with TickerProviderStateMixin {
  CubeModel cb;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    cb = widget.cb;
    cb.init();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..addListener(() {
            setState(() {
              cb.rotateAroundZ(400.0 * animationController.value);
            });
          })
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
              cb.pointOfRotation.x, cb.pointOfRotation.y, cb.pointOfRotation.z),
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
        Transform(
            transform: Matrix4.translationValues(
                cb.getPoint(0).x, cb.getPoint(0).y, cb.getPoint(0).z),
            child: Container(
              height: 10.0,
              width: 10.0,
              color: Colors.pink,
            )),
      ]..addAll(cb.getPoints().map((pt) {
          return Transform(
            transform: Matrix4.translationValues(
              pt.x,
              pt.y,
              pt.z,
            ),
            child: FractionalTranslation(
              translation: Offset(-0.5, -0.5),
              child: Container(
                height: 10.0 + (200 + pt.z) / 5.0,
                width: 10.0 + (200 + pt.z) / 5.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        })),
    );
  }
}
/*import 'dart:math';
import 'package:flutter/material.dart';

class CubeModel {
  final Rotation3d pointOfRotation;
  double radius;
  double pointSizeAtCenter;
  double centerToPlane;
  double diagonal;

  List<Rotation3d> points = [];

  CubeModel(
      {this.pointOfRotation,
      this.radius = 100.0,
      this.pointSizeAtCenter = 30.0});

  getPoint(int index){
    points[index]
  }
  init() {
    centerToPlane = (radius) / sqrt(3);
    diagonal = sqrt(pow(radius, 2) - pow(centerToPlane, 2));

    //Point3d FTL, FTR, FBL, FBR, BTL, BTR, BBL, BBR;
    //for (int i = 0; i < 8; i++) {


    /*points.add(Point3d(
          // makes cube
          x: (i < 4)
              ? pointOfRotation.x
              : (i < 6)
                  ? pointOfRotation.x - (radius / sqrt(3))
                  : pointOfRotation.x + (radius / sqrt(3)),
          y: (i % 2 == 0)
              ? pointOfRotation.y + (radius / sqrt(3))
              : pointOfRotation.y - (radius / sqrt(3)),
          z: (i < 2)
              ? pointOfRotation.z + radius
              : (i < 4) ? pointOfRotation.z - radius : pointOfRotation.z));*/
    //  }
  }

  rotateAroundY(double percentOfQuarterRotation) {
    // in the form of
    /* z' = z*cos q - x*sin q
     x' = z*sin q + x*cos q
       y' = y
*/

    points.forEach((point) {
      point.x = pointOfRotation.x -
          diagonal *
              (cos(2 *
                  pi *
                  ((point.yAxisRotation + percentOfQuarterRotation) / 400)));
      point.z = pointOfRotation.z +
          diagonal *
              (sin(2 *
                  pi *
                  ((point.yAxisRotation + percentOfQuarterRotation) / 400)));
    });
  }

  rotateAroundX(double percentOfQuarterRotation) {
    // in the form of
    /* z' = z*cos q - x*sin q
     x' = z*sin q + x*cos q
       y' = y
*/

    points.forEach((point) {
      point.y = (point.x == pointOfRotation.x)
          ? pointOfRotation.y +
              radius *
                  (sin(2 *
                      pi *
                      ((point.xAxisRotation + percentOfQuarterRotation) / 400)))
          : pointOfRotation.y +
              diagonal *
                  (sin(2 *
                      pi *
                      ((point.xAxisRotation + percentOfQuarterRotation) /
                          400)));
      point.z = pointOfRotation.z -
          diagonal *
              (cos(2 *
                  pi *
                  ((point.xAxisRotation + percentOfQuarterRotation) / 400)));
    });
  }
}

class Rotation3d {

  double size;
  Spot spot;
  final double initxAxisRotation, inityAxisRotation, initzAxisRotation;

  Rotation3d(
      {
      this.size = 50.0,
      @required this.spot,
      this.initxAxisRotation,
      this.inityAxisRotation,
      this.initzAxisRotation});

  double xAxisRotation, yAxisRotation, zAxisRotation;

  //double zplaneScale;
}

class Point3d{
  double x, y, z;
  Point3d({
    @required this.x,
    @required this.y,
    @required this.z,
});


}
class Point2d {
  double x;
  double y;

  Point2d(double x, double y) {
    this.x = x;
    this.y = y;
  }
}

enum Spot {
  FrontCenterTop,
  FrontCenterBottom,
  MiddleLeftTop,
  MiddleRightTop,
  MiddleLeftBottom,
  MiddleRightBottom,
  BackCenterTop,
  BackCenterBottom,
  Center
}
/*    points.add(Rotation3d(
        x: pointOfRotation.x,
        y: pointOfRotation.y - centerToPlane,
        z: pointOfRotation.z + diagonal,
        spot: Spot.FrontCenterTop,
        xAxisRotation: 50.0,
        yAxisRotation: 100.0,
        zAxisRotation: 100.0));
    points.add(Rotation3d(
        x: pointOfRotation.x,
        y: pointOfRotation.y + centerToPlane,
        z: pointOfRotation.z + diagonal,
        spot: Spot.FrontCenterBottom,
        xAxisRotation: 350.0,
        yAxisRotation: 100.0,
        zAxisRotation: 300.0));

    points.add(Rotation3d(
        x: pointOfRotation.x - diagonal,
        y: pointOfRotation.y - centerToPlane,
        z: pointOfRotation.z,
        spot: Spot.MiddleLeftTop,
        xAxisRotation: 100.0,
        yAxisRotation: 200.0,
        zAxisRotation: 150.0));
    points.add(Rotation3d(
        x: pointOfRotation.x + diagonal,
        y: pointOfRotation.y - centerToPlane,
        z: pointOfRotation.z,
        spot: Spot.MiddleRightTop,
        xAxisRotation: 100.0,
        yAxisRotation: 0.0,
        zAxisRotation: 50.0));
    points.add(Rotation3d(
        x: pointOfRotation.x - diagonal,
        y: pointOfRotation.y + centerToPlane,
        z: pointOfRotation.z,
        spot: Spot.MiddleLeftBottom,
        xAxisRotation: 300.0,
        yAxisRotation: 200.0,
        zAxisRotation: 250.0));
    points.add(Rotation3d(
        x: pointOfRotation.x + diagonal,
        y: pointOfRotation.y + centerToPlane,
        z: pointOfRotation.z,
        spot: Spot.MiddleRightBottom,
        xAxisRotation: 300.0,
        yAxisRotation: 0.0,
        zAxisRotation: 350.0));

    points.add(Rotation3d(
        x: pointOfRotation.x,
        y: pointOfRotation.y - centerToPlane,
        z: pointOfRotation.z - diagonal,
        spot: Spot.BackCenterTop,
        initxAxisRotation: 150.0,
        yAxisRotation: 300.0,
        zAxisRotation: 100.0));
    points.add(Rotation3d(
        x: pointOfRotation.x,
        y: pointOfRotation.y + centerToPlane,
        z: pointOfRotation.z - diagonal,
        spot: Spot.BackCenterBottom,
        xAxisRotation: 250.0,
        yAxisRotation: 300.0,
        zAxisRotation: 300.0));*/*/

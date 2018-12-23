import 'dart:math';
import 'package:flutter/material.dart';

class CubeModel {
  final Point3d pointOfRotation;
  double radius;
  double pointSizeAtCenter;
  double centerToPlane;
  double diagonal;

  List<Rotation3d> points = [];

  CubeModel(
      {this.pointOfRotation,
      this.radius = 100.0,
      this.pointSizeAtCenter = 30.0});

  Point3d getPoint(int index) {
    return Point3d(
      x: pointOfRotation.x +
          diagonal * cos(2 * pi * (points[index].zAxisRotation / 400.0)),
      y: pointOfRotation.y +
          diagonal * cos(2 * pi * (points[index].xAxisRotation / 400.0)),
      z: pointOfRotation.z -
          diagonal * cos(2 * pi * (points[index].yAxisRotation / 400.0)),
    );
  }

  List<Point3d> getPoints() {
    points.sort((r1, r2) => (pointOfRotation.z -
            diagonal * cos(2 * pi * (r1.yAxisRotation / 400.0)))
        .compareTo((pointOfRotation.z -
            diagonal * cos(2 * pi * (r1.yAxisRotation / 400.0)))));
    List<Point3d> p = [];
    points.forEach((pt) {
      p.add(Point3d(
        x: pointOfRotation.x +
            diagonal *
                cos(2 *
                    pi *
                    (pt.zAxisRotation /
                        400.0)), //diagonal * sin(2 * pi * (pt.yAxisRotation / 400.0)),
        y: pointOfRotation.y +
            diagonal * sin(2 * pi * (pt.zAxisRotation / 400.0)),
        z: pointOfRotation.z +
            diagonal * cos(2 * pi * (1 - pt.xAxisRotation / 400.0)) +
            diagonal * sin(2 * pi * (1 - pt.yAxisRotation / 400.0)),
      ));
    });
    return p;
  }

  init() {
    centerToPlane = (radius) / sqrt(3);
    diagonal = sqrt(pow(radius, 2) - pow(centerToPlane, 2));

    //Point3d FTL, FTR, FBL, FBR, BTL, BTR, BBL, BBR;
    //for (int i = 0; i < 8; i++) {

    // Right Front Top
    points.add(Rotation3d(
        initxAxisRotation: 50.0,
        inityAxisRotation: 350.0,
        initzAxisRotation: 50.0));

    //  Right Front Bottom
    points.add(Rotation3d(
        initxAxisRotation: 350.0,
        inityAxisRotation: 350.0,
        initzAxisRotation: 350.0));

    //Right back top
    points.add(Rotation3d(
        initxAxisRotation: 150.0,
        inityAxisRotation: 50.0,
        initzAxisRotation: 50.0));

    //right back bottom
    points.add(Rotation3d(
        initxAxisRotation: 250.0,
        inityAxisRotation: 50.0,
        initzAxisRotation: 350.0));

    // left front top
    points.add(Rotation3d(
        initxAxisRotation: 50.0,
        inityAxisRotation: 250.0,
        initzAxisRotation: 150.0));

    // left back top
    points.add(Rotation3d(
        initxAxisRotation: 150.0,
        inityAxisRotation: 150.0,
        initzAxisRotation: 150.0));

    // left front bottom
    points.add(Rotation3d(
        initxAxisRotation: 350.0,
        inityAxisRotation: 250.0,
        initzAxisRotation: 250.0));

    // left back bottom
    points.add(Rotation3d(
        initxAxisRotation: 250.0,
        inityAxisRotation: 150.0,
        initzAxisRotation: 250.0));
  }

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
              : (i < 4) ? pointOfRotation.z - radius : pointOfRotation.z));
    //  }
  }
*/
  rotateAroundY(double percentOfQuarterRotation) {
    // in the form of
//
    points.forEach((point) {
      point.yAxisRotation = point.inityAxisRotation + percentOfQuarterRotation;
    });
  }

  rotateAroundZ(double percentOfQuarterRotation) {
    // in the form of

    points.forEach((point) {
      point.zAxisRotation = point.initzAxisRotation + percentOfQuarterRotation;
      // point.zAxisRotation = point.initzAxisRotation - percentOfQuarterRotation;
    });
  }
/*
  rotateAroundX(double percentOfQuarterRotation) {
    // in the form of
     z' = z*cos q - x*sin q
     x' = z*sin q + x*cos q
       y' = y


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
  */
}

class Rotation3d {
  double size;
  //Spot spot;
  final double initxAxisRotation, inityAxisRotation, initzAxisRotation;
  double xAxisRotation, yAxisRotation, zAxisRotation;
  Rotation3d(
      {this.size = 50.0,
      // @required this.spot,
      this.initxAxisRotation,
      this.inityAxisRotation,
      this.initzAxisRotation}) {
    xAxisRotation = initxAxisRotation;
    yAxisRotation = inityAxisRotation;
    zAxisRotation = initzAxisRotation;
  }

  //double zplaneScale;
}

class Point3d {
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
        zAxisRotation: 300.0));*/

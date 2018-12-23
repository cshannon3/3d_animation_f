import 'dart:math';
import 'package:flutter/material.dart';
import 'trig.dart';

class SquareModel {
  final Pointrdo3d pointOfRotation;
  double radius;
  double pointSizeAtCenter;
  double centerToPlane;
  double diagonal;

  List<RotationPt3d> points = [];

  SquareModel(
      {this.pointOfRotation,
      this.radius = 100.0,
      this.pointSizeAtCenter = 30.0});

  Pointrdo3d getPoint(int index) {
    RotationPt3d pt = points[index];
    return Pointrdo3d(
      right: pt.initPosition.right *
              (Z(pt.downAxisFromRightRotation) *
                  Z(pt.outAxisFromRightRotation)) +
          pt.initPosition.out *
              (K(pt.rightAxisFromOutRotation) *
                  K(pt.outAxisFromRightRotation +
                      Z(pt.rightAxisFromOutRotation) *
                          K(pt.downAxisFromRightRotation) *
                          Z(pt.outAxisFromRightRotation))) +
          pt.initPosition.down *
              (-Z(pt.rightAxisFromOutRotation) *
                  K(pt.outAxisFromRightRotation +
                      K(pt.rightAxisFromOutRotation) *
                          K(pt.downAxisFromRightRotation) *
                          Z(pt.outAxisFromRightRotation))),
      //diagonal * sin(2 * pi * (pt.yAxisRotation / 400.0)),
      down: pt.initPosition.right *
              (Z(pt.downAxisFromRightRotation) *
                  K(pt.outAxisFromRightRotation)) +
          pt.initPosition.out *
              (-K(pt.rightAxisFromOutRotation) *
                  Z(pt.outAxisFromRightRotation +
                      Z(pt.downAxisFromRightRotation) *
                          K(pt.rightAxisFromOutRotation) *
                          K(pt.outAxisFromRightRotation))) +
          pt.initPosition.down *
              (Z(pt.rightAxisFromOutRotation) *
                  Z(pt.outAxisFromRightRotation +
                      K(pt.downAxisFromRightRotation) *
                          K(pt.rightAxisFromOutRotation) *
                          K(pt.outAxisFromRightRotation))),
      out: -pt.initPosition.right * K(pt.downAxisFromRightRotation) +
          pt.initPosition.out *
              (Z(pt.rightAxisFromOutRotation) *
                  Z(pt.downAxisFromRightRotation)) +
          pt.initPosition.down *
              (K(pt.rightAxisFromOutRotation) *
                  Z(pt.downAxisFromRightRotation)),
    );
  }

  /*List<Pointrdo3d> getPoints() {
    List<Pointrdo3d> p = [];
    points.forEach((pt) {
      p.add(Pointrdo3d(
        right: pointOfRotation.right +
            pt.initPosition.right *
                ((Z(pt.downAxisFromRightRotation) *
                        Z(pt.outAxisFromRightRotation)) +
                    Z(pt.downAxisFromRightRotation) *
                        (K(pt.rightAxisFromOutRotation) *
                            K(pt.outAxisFromRightRotation +
                                Z(pt.rightAxisFromOutRotation) *
                                    K(pt.downAxisFromRightRotation) *
                                    Z(pt.outAxisFromRightRotation)))),
        //diagonal * sin(2 * pi * (pt.yAxisRotation / 400.0)),
        down: pointOfRotation.down +
            pt.initPosition.right *
                ((Z(pt.downAxisFromRightRotation) *
                        K(pt.outAxisFromRightRotation)) +
                    Z(pt.downAxisFromRightRotation) *
                        (-K(pt.rightAxisFromOutRotation) *
                            Z(pt.outAxisFromRightRotation +
                                Z(pt.downAxisFromRightRotation) *
                                    K(pt.rightAxisFromOutRotation) *
                                    K(pt.outAxisFromRightRotation)))),
        out: pointOfRotation.out +
            pointOfRotation.right *
                (-K(pt.downAxisFromRightRotation) +
                    (Z(pt.rightAxisFromOutRotation) *
                        2 *
                        Z(pt.downAxisFromRightRotation))),
      ));
    });
    return p;
  }

  List<Pointrdo3d> getPoints() {
    List<Pointrdo3d> p = [];

    points.forEach((pt) {
      p.add(Pointrdo3d(
        right: pointOfRotation.right +
            pt.initPosition.right *
                (Z(pt.downAxisFromRightRotation) *
                    Z(pt.outAxisFromRightRotation)) +
            pt.initPosition.out *
                (K(pt.rightAxisFromOutRotation) *
                    K(pt.outAxisFromRightRotation +
                        Z(pt.rightAxisFromOutRotation) *
                            K(pt.downAxisFromRightRotation) *
                            Z(pt.outAxisFromRightRotation))) +
            pt.initPosition.down *
                (-Z(pt.rightAxisFromOutRotation) *
                    K(pt.outAxisFromRightRotation +
                        K(pt.rightAxisFromOutRotation) *
                            K(pt.downAxisFromRightRotation) *
                            Z(pt.outAxisFromRightRotation))),
        //diagonal * sin(2 * pi * (pt.yAxisRotation / 400.0)),
        down: pointOfRotation.down +
            pt.initPosition.right *
                (Z(pt.downAxisFromRightRotation) *
                    K(pt.outAxisFromRightRotation)) +
            pt.initPosition.out *
                (-K(pt.rightAxisFromOutRotation) *
                    Z(pt.outAxisFromRightRotation +
                        Z(pt.downAxisFromRightRotation) *
                            K(pt.rightAxisFromOutRotation) *
                            K(pt.outAxisFromRightRotation))) +
            pt.initPosition.down *
                (Z(pt.rightAxisFromOutRotation) *
                    Z(pt.outAxisFromRightRotation +
                        K(pt.downAxisFromRightRotation) *
                            K(pt.rightAxisFromOutRotation) *
                            K(pt.outAxisFromRightRotation))),
        out: pointOfRotation.out -
            pointOfRotation.right * K(pt.downAxisFromRightRotation) +
            pt.initPosition.out *
                (Z(pt.rightAxisFromOutRotation) *
                    Z(pt.downAxisFromRightRotation)) +
            pt.initPosition.down *
                (K(pt.rightAxisFromOutRotation) *
                    Z(pt.downAxisFromRightRotation)),
      ));
    });
    return p;
  }
*/
  List<Pointrdo3d> getPoints() {
    List<Pointrdo3d> p = [];

    points.forEach((pt) {
      p.add(Pointrdo3d(
        right: pointOfRotation.right +
            pt.initPosition.right *
                (Z(pt.downAxisFromRightRotation) *
                    Z(pt.outAxisFromRightRotation)) +
            pt.initPosition.out *
                (K(pt.rightAxisFromOutRotation) *
                    K(pt.outAxisFromRightRotation +
                        Z(pt.rightAxisFromOutRotation) *
                            K(pt.downAxisFromRightRotation) *
                            Z(pt.outAxisFromRightRotation))) +
            pt.initPosition.down *
                (-Z(pt.rightAxisFromOutRotation) *
                    K(pt.outAxisFromRightRotation +
                        K(pt.rightAxisFromOutRotation) *
                            K(pt.downAxisFromRightRotation) *
                            Z(pt.outAxisFromRightRotation))),
        //diagonal * sin(2 * pi * (pt.yAxisRotation / 400.0)),
        down: pointOfRotation.down +
            pt.initPosition.right *
                (Z(pt.downAxisFromRightRotation) *
                    K(pt.outAxisFromRightRotation)) +
            pt.initPosition.out *
                (-K(pt.rightAxisFromOutRotation) *
                    Z(pt.outAxisFromRightRotation +
                        Z(pt.downAxisFromRightRotation) *
                            K(pt.rightAxisFromOutRotation) *
                            K(pt.outAxisFromRightRotation))) +
            pt.initPosition.down *
                (Z(pt.rightAxisFromOutRotation) *
                    Z(pt.outAxisFromRightRotation +
                        K(pt.downAxisFromRightRotation) *
                            K(pt.rightAxisFromOutRotation) *
                            K(pt.outAxisFromRightRotation))),
        out: pointOfRotation.out -
            pt.initPosition.right * K(pt.downAxisFromRightRotation) +
            pt.initPosition.out *
                (Z(pt.rightAxisFromOutRotation) *
                    Z(pt.downAxisFromRightRotation)) +
            pt.initPosition.down *
                (K(pt.rightAxisFromOutRotation) *
                    Z(pt.downAxisFromRightRotation)),
      ));
    });
    return p;
  }

  init() {
    centerToPlane = (radius) / sqrt(3);
    diagonal = sqrt(pow(radius, 2) - pow(centerToPlane, 2));
    points = [];
    //Pointrdo3d FTL, FTR, FBL, FBR, BTL, BTR, BBL, BBR;
    //for (int i = 0; i < 8; i++) {
/*
    // Front Center
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(right: radius, down: 0.0, out: 0.0)));

    //  Right Middle Left
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(right: 0.0, down: 0.0, out: radius)));

    //back back
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(right: -radius, down: 0.0, out: 0.0)));

    //left middle
    /


    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(right: 0.0, down: 0.0, out: -radius)));

    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(right: 0.0, down: radius, out: 0.0)));
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(right: 0.0, down: -radius, out: 0.0)));*/
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(
            right: centerToPlane, down: centerToPlane, out: centerToPlane)));
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(
            right: centerToPlane, down: centerToPlane, out: -centerToPlane)));
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(
            right: centerToPlane, down: -centerToPlane, out: centerToPlane)));
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(
            right: centerToPlane, down: -centerToPlane, out: -centerToPlane)));
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(
            right: -centerToPlane, down: centerToPlane, out: centerToPlane)));
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(
            right: -centerToPlane, down: centerToPlane, out: -centerToPlane)));
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(
            right: -centerToPlane, down: -centerToPlane, out: centerToPlane)));
    points.add(RotationPt3d(
        initRightAxisFromOutRotation: 0.0,
        initDownAxisFromRightRotation: 0.0,
        initOutAxisFromRightRotation: 0.0,
        initPosition: Pointrdo3d(
            right: -centerToPlane, down: -centerToPlane, out: -centerToPlane)));
  }

  rotateAroundDown(double percentOfQuarterRotation) {
    // in the form of
//
    points.forEach((point) {
      point.downAxisFromRightRotation =
          percentOfQuarterRotation + point.initPosition.out / radius;
      // point.outAxisFromRightRotation = point.initPosition.out < pointOfRotation.out ? 250.0 : 0.0;
    });
  }

  rotateAroundOut(double percentOfQuarterRotation) {
    points.forEach((point) {
      point.outAxisFromRightRotation = percentOfQuarterRotation;
      point.rightAxisFromOutRotation = 200.0;
      // point.downAxisFromRightRotation = percentOfQuarterRotation;
    });
  }

  rotateAroundRight(double percentOfQuarterRotation) {
    points.forEach((point) {
      point.outAxisFromRightRotation = 200.0;
      point.rightAxisFromOutRotation = percentOfQuarterRotation;
    });
  }

  rotateAround(double percentOfQuarterRotation) {
    points.forEach((point) {
      point.outAxisFromRightRotation = percentOfQuarterRotation;
      point.rightAxisFromOutRotation = percentOfQuarterRotation;
    });
  }
}

class RotationPt3d {
  double size;
  //Spot spot;

  final double initRightAxisFromOutRotation,
      initDownAxisFromRightRotation,
      initOutAxisFromRightRotation;
  double rightAxisFromOutRotation,
      downAxisFromRightRotation,
      outAxisFromRightRotation;
  final Pointrdo3d initPosition;
  RotationPt3d(
      {this.size = 50.0,
      // @required this.spot,
      this.initRightAxisFromOutRotation,
      this.initDownAxisFromRightRotation,
      this.initOutAxisFromRightRotation,
      this.initPosition}) {
    rightAxisFromOutRotation = initRightAxisFromOutRotation;
    downAxisFromRightRotation = initDownAxisFromRightRotation;
    outAxisFromRightRotation = initOutAxisFromRightRotation;
  }

//double zplaneScale;
}

class Pointrdo3d {
  double right, down, out;
  Pointrdo3d({
    @required this.right,
    @required this.down,
    @required this.out,
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

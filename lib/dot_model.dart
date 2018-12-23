import 'dart:math';
import 'package:flutter/material.dart';
import 'package:folding_cells_f/square_model.dart';
import 'trig.dart';

class DotModel {
  final Pointrdo3d pointOfRotation;
  double radius;
  double pointSizeAtCenter;
  double centerToPlane;
  double diagonal;

  List<RotationDot3d> points = [];

  DotModel(
      {this.pointOfRotation,
      this.radius = 100.0,
      this.pointSizeAtCenter = 30.0});

  /*CircleSlice getCircleSlice(int index, RotationDirection rotationdir){
    Pointrdo3d p = getPoint(index);
    return CircleSlice(radius: rotationdir == RotationDirection.aroundOut ? centerToPlane
    : (rotationdir == RotationDirection.aroundRight) ?
    ;

}*/
  double getOutRadius(int index) {
    return sqrt(pow(getPoint(index).down, 2) + pow(getPoint(index).right, 2));
  }

  Pointrdo3d getPoint(int index) {
    RotationDot3d pt = points[index];
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
    p.sort((p1, p2) => p1.out.compareTo(p2.out));
    return p;
  }

  init() {
    centerToPlane = (radius) / sqrt(3);
    diagonal = sqrt(pow(radius, 2) - pow(centerToPlane, 2));
    points = [];

    points.add(RotationDot3d(
        initPosition: Pointrdo3d(right: radius, down: 0.0, out: 0.0)));
    points.add(RotationDot3d(
        initPosition: Pointrdo3d(right: -radius, down: 0.0, out: 0.0)));
    points.add(RotationDot3d(
        initPosition: Pointrdo3d(right: 0.0, down: radius, out: 0.0)));
    points.add(RotationDot3d(
        initPosition: Pointrdo3d(right: 0.0, down: -radius, out: 0.0)));

    //  points.add(RotationDot3d(initPosition: Pointrdo3d(right: -radius / 2, down: 0.0, out: 0.0)));
    //points.add(RotationDot3d(initPosition: Pointrdo3d(right: radius / 2, down: 0.0, out: 0.0)));
    points.add(RotationDot3d(
        initPosition: Pointrdo3d(
            right: radius / sqrt(2), down: radius / sqrt(2), out: 0.0)));
    points.add(RotationDot3d(
        initPosition: Pointrdo3d(
            right: -radius / sqrt(2), down: -radius / sqrt(2), out: 0.0)));
    points.add(RotationDot3d(
        initPosition: Pointrdo3d(
            right: radius / sqrt(2), down: -radius / sqrt(2), out: 0.0)));
    points.add(RotationDot3d(
        initPosition: Pointrdo3d(
            right: -radius / sqrt(2), down: radius / sqrt(2), out: 0.0)));
  }

  rotateAroundDown(double percentOfQuarterRotation) {
    // in the form of
//
    points.forEach((point) {
      point.downAxisFromRightRotation = percentOfQuarterRotation;
      // point.outAxisFromRightRotation = point.initPosition.out < pointOfRotation.out ? 250.0 : 0.0;
    });
  }

  rotateAroundOut(double percentOfQuarterRotation) {
    points.forEach((point) {
      point.outAxisFromRightRotation = percentOfQuarterRotation;

      point.downAxisFromRightRotation = percentOfQuarterRotation;
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

class RotationDot3d {
  double size;
  //Spot spot;

  double rightAxisFromOutRotation,
      downAxisFromRightRotation,
      outAxisFromRightRotation;
  final Pointrdo3d initPosition;
  RotationDot3d(
      {this.size = 50.0,
      // @required this.spot,
      this.initPosition}) {
    rightAxisFromOutRotation = 0.0; //initPosition.right / 200.0;
    downAxisFromRightRotation = 0.0; //initPosition.down / 200.0;
    outAxisFromRightRotation = 0.0; //initPosition.out / 200.0;
  }

//double zplaneScale;
}

class CircleSlice {
  double radius;
  Pointrdo3d center;

  CircleSlice({
    this.radius,
    this.center,
  });
}

enum RotationDirection {
  aroundOut,
  aroundRight,
  aroundDown,
}

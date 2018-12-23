import 'package:flutter/material.dart';
import 'package:folding_cells_f/cube.dart';
import 'dart:math';

import 'package:folding_cells_f/cube_model.dart';
import 'package:folding_cells_f/dot_model.dart';
import 'package:folding_cells_f/dot_view.dart';
import 'package:folding_cells_f/square_model.dart';
import 'package:folding_cells_f/square_view.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        // showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        title: 'Flip Carousel',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(body: Home())

        //new MyHomePage(),
        );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Pointrdo3d pointOfRotation = Pointrdo3d(
      right: MediaQuery.of(context).size.width / 2,
      down: MediaQuery.of(context).size.height / 2,
      out: -50.0,
    );
    DotModel cb = DotModel(
        pointSizeAtCenter: 30.0,
        pointOfRotation: pointOfRotation,
        radius: 150.0);
    return DotView(
      cb: cb,
      /* SquareModel cb = SquareModel(
        pointSizeAtCenter: 30.0,
        pointOfRotation: pointOfRotation,
        radius: 80.0);

    //cb.rotateAroundX(400.0 * animationController.value);

    return SquareView(
      cb: cb,*/
    );
  }
}
/*class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Point3d pointOfRotation = Point3d(
      x: MediaQuery.of(context).size.width / 2,
      y: MediaQuery.of(context).size.height / 2,
      z: -50.0,
    );
    CubeModel cb = CubeModel(
        pointSizeAtCenter: 30.0,
        pointOfRotation: pointOfRotation,
        radius: 80.0);

    //cb.rotateAroundX(400.0 * animationController.value);

    return Cube(
      cb: cb,
    );
  }
}
*/

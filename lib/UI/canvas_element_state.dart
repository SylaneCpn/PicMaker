import 'package:flutter/material.dart';
import 'dart:math' as maths;

abstract class CanvasElementState {
  double xPos = 0.0;
  double yPos = 0.0;
  double angle = maths.pi;
  double xScale = 1.0;
  double yScale = 1.0;


  void updatePos(double dx, double dy) {
    xPos += dx;
    yPos += dy;
  }


  void updateScale(double xScale , double yScale) {
    this.xScale = xScale;
    this.yScale = yScale;
  }

  void updateAngle(double angle) {
    this.angle = angle;
  }

  Widget toWidget(int index);

  Widget controlPanel();
} 
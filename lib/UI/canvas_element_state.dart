import 'package:flutter/material.dart';
import 'dart:math' as maths;

import 'package:pic_maker/UI/custom_canvas.dart';

abstract class CanvasElementState {
  double xPos = 0.0;
  double yPos = 0.0;
  double angle = maths.pi;


  void updatePos(CustomCanvasState canvasState, double dx, double dy) {
    xPos += dx;
    yPos += dy;
    canvasState.notify();
  }




  void updateAngle(CustomCanvasState canvasState,double angle) {
    this.angle = angle;
    canvasState.notify();
  }

  Widget toWidget(int index);

  Widget controlPanel();
} 
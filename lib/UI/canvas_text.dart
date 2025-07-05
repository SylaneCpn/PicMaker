import 'package:flutter/material.dart';
import 'package:pic_maker/UI/canvas_element_state.dart';

class CanvasTextState extends CanvasElementState {
  String text;
  CanvasTextState({required this.text , double x = 0 , double y = 0 }) {
    xPos = x;
    yPos = y;
  }

  @override
  Widget toWidget(int index) {
    return Placeholder();
  }

  @override
  Widget controlPanel() {
    return controlPanel();
  }
}
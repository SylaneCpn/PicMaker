import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pic_maker/UI/canvas_element_state.dart';
import 'package:pic_maker/UI/custom_canvas.dart';
import 'package:provider/provider.dart';

class CanvasTextState extends CanvasElementState {
  late TextEditingController textController;
  String? font;
  CanvasTextState({required String text, this.font, double x = 200.0, double y = 200.0}) {
    textController = TextEditingController(text: text);
    xPos = x;
    yPos = y;
  }


  void updateText(String newText) {
    textController.text = newText;
  }

  @override
  Widget toWidget(int index) {
    return CanvasText(index: index);
  }

  @override
  Widget controlPanel() {
    return TextControlPannel();
  }
}

class CanvasText extends StatelessWidget {
  final int index;
  const CanvasText({super.key, required this.index});
  

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    final element = state.canvasElementsStates[index] as CanvasTextState;
    return Positioned(
      top: element.yPos,
      left: element.xPos,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          state.updatePos(index, tapInfo.delta.dx, tapInfo.delta.dy);
        },
        onTap: () {
          state.putOnTop(index);
        },
        child: Transform.rotate(
          angle: element.angle - math.pi,
          child: SizedBox(
            width: 200.0 * element.xScale,
            height: 200.0 * element.yScale,
            child: FittedBox(
              child: Text(
                style: TextStyle(fontFamily: element.font),
                element.textController.text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class TextControlPannel extends StatelessWidget {
  const TextControlPannel({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    final index = state.canvasElementsStates.length - 1;
    final element = state.canvasElementsStates[index] as CanvasTextState;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Texte", style: TextStyle(fontSize: 18.0)),
              ),
            ),
            TextField(
              controller: element.textController ,
              onSubmitted: (String newText) => state.updateText(index, newText),
            ),
          ],
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Angle", style: TextStyle(fontSize: 18.0)),
              ),
            ),
            Slider(
              value: element.angle,
              onChanged: (double value) => state.updateAngle(index, value),
              max: 2 * math.pi,
            ),
          ],
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Largeur", style: TextStyle(fontSize: 18.0)),
              ),
            ),
            Slider(
              value: element.xScale,
              onChanged:
                  (double value) => state.updatexScale(index, value),
              min: 0.1,
              max: 10.0,
            ),
          ],
        ),
         Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Hauteur", style: TextStyle(fontSize: 18.0)),
              ),
            ),
            Slider(
              value: element.yScale,
              onChanged:
                  (double value) => state.updateyScale(index, value),
              min: 0.1,
              max: 10.0,
            ),
          ],
        ),
        Align(
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.red),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red),
                ),
              ),
            ),
            onPressed: state.removeCanvasElement,
            child: Text("Supprimer l'élément"),
          ),
        ),
      ],
    );
  }
}
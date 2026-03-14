import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pic_maker/UI/canvas_element_state.dart';
import 'package:pic_maker/UI/custom_canvas.dart';
import 'package:provider/provider.dart';

class CanvasTextState extends CanvasElementState {
  String? font;
  double xScale;
  double yScale;
  String text;

  CanvasTextState({required this.text, this.font, double x = 200.0, double y = 200.0 , this.xScale = 1.0, this.yScale = 1.0}) {
    xPos = x;
    yPos = y;
  }



  void updateXScale(CustomCanvasState canvasState , double x) {
    xScale = x;
    canvasState.notify();
  }

  void updateYScale(CustomCanvasState canvasState , double y) {
    yScale = y;
    canvasState.notify();
  }

  void updateText(CustomCanvasState canvasState , String newText ) {
    text = newText;
    canvasState.notify();
  }

  @override
  Widget toWidget(int index) {
    return CanvasText(text: text, index: index);
  }

  @override
  Widget controlPanel() {
    return TextControlPannel(baseText: text,);
  }
}

class CanvasText extends StatelessWidget {
  final int index;
  final String text;
  const CanvasText({super.key, required this.index , required this.text});
  

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    final element = state.canvasElementsStates[index] as CanvasTextState;
    return Positioned(
      top: element.yPos,
      left: element.xPos,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          element.updatePos(state, tapInfo.delta.dx, tapInfo.delta.dy);
        },
        onTap: () {
          state.putOnTop(index);
        },
        child: Transform.scale(
          scaleX: element.xScale,
          scaleY: element.yScale,
          child: Transform.rotate(
            angle: element.angle - math.pi,
            child: Text(
              style: TextStyle(fontFamily: element.font),
              text,
            ),
          ),
        ),
      ),
    );
  }
}


class TextControlPannel extends StatefulWidget {
  final String baseText;
  const TextControlPannel({super.key, required this.baseText});

  @override
  State<TextControlPannel> createState() => _TextControlPannelState();
}

class _TextControlPannelState extends State<TextControlPannel> {

  late final TextEditingController _controller = TextEditingController(text : widget.baseText);

   


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


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
              controller: _controller ,
              onChanged: (String newText) => element.updateText(state, newText),
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
              onChanged: (double value) => element.updateAngle(state, value),
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
                  (double value) => element.updateXScale(state, value),
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
                  (double value) => element.updateYScale(state, value),
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
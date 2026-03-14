import 'package:flutter/material.dart';
import 'package:pic_maker/UI/canvas_element_state.dart';
import 'package:pic_maker/UI/custom_canvas.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class CanvasImageState extends CanvasElementState {
  ImageProvider img;
  double scale = 1.0;
  CanvasImageState({required this.img, double x = 0, double y = 0}) {
    xPos = x;
    yPos = y;
  }

  @override
  Widget toWidget(int index) {
    return CanvasImage(index: index);
  }

  @override
  Widget controlPanel() {
    return ImageControlPannel();
  }


  void updateScale(CustomCanvasState canvasState , double newScale) {
    scale = newScale;
    canvasState.notify();
  }


}

class CanvasImage extends StatelessWidget {
  final int index;
  const CanvasImage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    final element = state.canvasElementsStates[index] as CanvasImageState;
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
          scale: element.scale,
          child: Transform.rotate(
            angle: element.angle - math.pi,
            child: Image(
              filterQuality: FilterQuality.high,
              image: element.img),
          ),
        ),
      ),
    );
  }
}

class ImageControlPannel extends StatelessWidget {
  const ImageControlPannel({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    final index = state.canvasElementsStates.length - 1;
    final element = state.canvasElementsStates[index] as CanvasImageState;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
                child: Text("Taille", style: TextStyle(fontSize: 18.0)),
              ),
            ),
            Slider(
              value: element.scale,
              onChanged:
                  (double value) => element.updateScale(state, value),
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

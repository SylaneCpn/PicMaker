import 'package:flutter/material.dart';
import 'package:pic_maker/UI/canvas_element_state.dart';
import 'package:pic_maker/UI/canvas_image.dart';
import 'package:pic_maker/UI/default_background.dart';
import 'package:pic_maker/UI/default_panel.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class CustomCanvasState extends ChangeNotifier {
  CustomCanvasState();

  List<CanvasElementState> canvasElementsStates = [];
  Image? backgroundImage;
  bool selected = false;

  void addAssetImageToCanvas(String path) {
    canvasElementsStates.add(CanvasImageState(img: AssetImage(path)));
    notifyListeners();
  }
  void addCustomCanvasImage() {

  }

  void toggleSelected() {
    selected = !selected;
  }

  void removeCanvasElement() {
    canvasElementsStates.removeLast();
    selected = false;
    notifyListeners();
  }

  void setBackgroundFromAsset(String path) {
    backgroundImage = Image.asset(path, fit: BoxFit.fill);
    notifyListeners();
  }

  void putOnTop(int index) {
    if (!selected || index != canvasElementsStates.length - 1) {
      final toPutOnTop = canvasElementsStates.removeAt(index);
      canvasElementsStates.add(toPutOnTop);
      selected = true;
    } else if (selected && index == canvasElementsStates.length - 1) {
      selected = false;
    }

    notifyListeners();
  }

  void addElement() {
    canvasElementsStates.add(
      CanvasImageState(
        img: NetworkImage(
          "https://sylanecpn.github.io/assets/img/portrait.jpg",
        ),
      ),
    );
    selected = true;
    notifyListeners();
  }

  void updatePos(int index, double dx, double dy) {
    canvasElementsStates[index].updatePos(dx, dy);
    notifyListeners();
  }

  void updateAngle(int index, double angle) {
    canvasElementsStates[index].updateAngle(angle);
    notifyListeners();
  }

  void updateScale(int index, double xScale, double yScale) {
    canvasElementsStates[index].updateScale(xScale, yScale);
    notifyListeners();
  }
}

class CustomCanvasWidget extends StatelessWidget {
  const CustomCanvasWidget({super.key});
  

  List<Widget> buildStack(List<CanvasElementState> elementsStates) {
    return elementsStates
        .mapIndexed((index, element) => element.toWidget(index))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    final controllerSizeFactor = 0.33;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final horizon = constraints.maxWidth > constraints.maxHeight;

          final children = [
            Expanded(
              child: Center(
                child:
                    state.backgroundImage == null
                        ? DefaultBackground()
                        : Stack(
                          children: [
                            state.backgroundImage!,
                            ...buildStack(state.canvasElementsStates),
                          ],
                        ),
              ),
            ),
            Card(
              child: SizedBox(
                height:
                    horizon
                        ? null
                        : MediaQuery.of(context).size.height *
                            controllerSizeFactor,
                width:
                    horizon
                        ? MediaQuery.of(context).size.width *
                            controllerSizeFactor
                        : null,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 0.8,
                    right: 0.8,
                    left: 0.8,
                  ),
                  child:
                      state.selected
                          ? state
                              .canvasElementsStates[state
                                      .canvasElementsStates
                                      .length -
                                  1]
                              .controlPanel()
                          : DefaultPanel(),
                ),
              ),
            ),
          ];
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).primaryColorDark, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Center(
                child:
                    horizon
                        ? Row(
                          mainAxisSize: MainAxisSize.max,
                          children: children,
                        )
                        : Column(
                          mainAxisSize: MainAxisSize.max,
                          children: children,
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomCanvas extends StatelessWidget {
  const CustomCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomCanvasState(),
      child: CustomCanvasWidget(),
    );
  }
}

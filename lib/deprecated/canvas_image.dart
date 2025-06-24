// import 'package:flutter/material.dart';
// import 'package:pic_maker/UI/custom_canvas.dart';

// import 'package:provider/provider.dart';

// class CanvasImageState extends ChangeNotifier {
//   CanvasImageState({
//     required this.widgetRef,
//     this.xPos = 0,
//     this.yPos = 0,
//     this.img,
//   });

//   double xPos;
//   double yPos;
//   double angle = 0.0;
//   double scale = 0.0;
//   Image? img;
//   bool selected = false;
//   final CanvasImage widgetRef;

//   void updatePos(double dx, double dy) {
//     xPos += dx;
//     yPos += dy;
//     notifyListeners();
//   }

//   void toggleSelected() {
//     selected = !selected;
//   }

//   void onTap(CustomCanvasState parentState) {
//     if (selected) {
//       toggleSelected();
//       resetImage();
//     } else {
//       toggleSelected();
//       setImage();
//       parentState.putOnTop(widgetRef);
//     }

//     notifyListeners();
//   }

//   void setImage() {
//     img = Image.network("https://sylanecpn.github.io/assets/img/portrait.jpg");
//   }

//   void resetImage() {
//     img = null;
//   }
// }

// class CanvasImageWidget extends StatelessWidget {
//   const CanvasImageWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final parentState = context.read<CustomCanvasState>();
//     final state = context.watch<CanvasImageState>();
//     return Positioned(
//       top: state.yPos,
//       left: state.xPos,
//       child: Transform(
//         transform: Matrix4.rotationZ(state.angle),
//         child: GestureDetector(
//           onPanUpdate: (tapInfo) {
//             state.updatePos(tapInfo.delta.dx, tapInfo.delta.dy);
//           },
//           onTap: () {
//             state.onTap(parentState);
//           },
//           child: SizedBox(
//             width: 50.0,
//             height: 50.0,
//             child:
//                 state.img ??
//                 SizedBox(
//                   width: 50.0,
//                   height: 50.0,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                     ),
//                     child: Container(color: Colors.blueAccent),
//                   ),
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CanvasImage extends StatelessWidget {
//   const CanvasImage({super.key, this.xPos = 0, this.yPos = 0, this.img});

//   final double xPos;
//   final double yPos;
//   final Image? img;

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create:
//           (context) => CanvasImageState(
//             widgetRef: this,
//             xPos: xPos,
//             yPos: yPos,
//             img: img,
//           ),
//       child: CanvasImageWidget(),
//     );
//   }
// }

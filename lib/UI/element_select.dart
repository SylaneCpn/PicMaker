import 'package:flutter/widgets.dart';
import 'package:pic_maker/UI/custom_canvas.dart';
import 'package:provider/provider.dart';

class ElementSelect extends StatelessWidget{
  final String assetPath;

  const ElementSelect({super.key , required this.assetPath});



  @override
  Widget build(BuildContext context) {
    final state = context.read<CustomCanvasState>();
    return GestureDetector(
      onTap: () {
        state.setBackgroundFromAsset(assetPath);
      },
      child: Image.asset(
        fit: BoxFit.cover,
        assetPath),
    );
  }
}
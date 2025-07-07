import 'package:flutter/widgets.dart';

class AssetButton extends StatelessWidget{
  final String assetPath;
  final void Function(String) onTap;

  const AssetButton({super.key , required this.assetPath ,required this.onTap});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(assetPath);
      },
      child: Image.asset(
        fit: BoxFit.cover,
        assetPath),
    );
  }
}
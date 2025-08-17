import 'package:flutter/material.dart';

class FontButton extends StatelessWidget{
  final String fontFamily;
  final void Function(String) onTap;

  const FontButton({super.key , required this.fontFamily,required this.onTap});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(fontFamily);
      },
      child: Card(
        child: FittedBox(
          child : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(fontFamily,style: TextStyle(fontFamily: fontFamily),),
          )
        ),
      ),
    );
  }
}
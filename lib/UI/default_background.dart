import 'package:flutter/material.dart';

class DefaultBackground extends StatelessWidget{
  const DefaultBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary , fontSize: 30.0 , fontWeight: FontWeight.bold), "Aucun fond sélectionné."),
          Text(style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),"Selectionnez un fond")
        ],
      ),
    );
  }
}
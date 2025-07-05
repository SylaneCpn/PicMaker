import 'package:flutter/material.dart';

class AddCard  extends StatelessWidget{
  final void Function()? onTap;
  const AddCard({super.key ,this.onTap});


  @override
  Widget build(BuildContext context) {
    return Card(
      child: IconButton(onPressed: onTap, icon: Icon(Icons.add)),
    );
  }
}
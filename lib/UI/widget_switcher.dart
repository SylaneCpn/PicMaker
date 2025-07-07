import 'package:flutter/material.dart';

class WidgetSwitcher  extends StatelessWidget {
final Widget defaultWidget;
final Widget onConditionWidget;
final bool condition;

const WidgetSwitcher({super.key, required this.defaultWidget, required this.onConditionWidget, required this.condition});

@override
  Widget build(BuildContext context) {
    return [defaultWidget,onConditionWidget] [condition ? 1 : 0 ];
  }
}


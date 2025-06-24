import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:pic_maker/UI/background_select.dart';
import 'package:pic_maker/UI/custom_canvas.dart';
import 'package:provider/provider.dart';

class DefaultPanel extends StatefulWidget {
  final bool horizon;
  const DefaultPanel({super.key, required this.horizon});

  @override
  State<DefaultPanel> createState() => _DefaultPanelState();
}

class _DefaultPanelState extends State<DefaultPanel> {
  final tabs = [
    ("Fond", BackgroundSelect(),Icons.photo),
    ("Image", Placeholder(),Icons.text_fields_outlined),
    ("Texte", Placeholder(),Icons.add_photo_alternate_rounded),
  ];

  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget tabBarElement(int index, IconData icon, [bool activated = true]) {
    return Expanded(
      child: Align(
        child: InkWell(
          onTap: () {
            if (activated) {
              setSelectedIndex(index);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            decoration:
                index == selectedIndex
                    ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).primaryColorDark,
                          width: 2.0,
                        ),
                      ),
                    )
                    : null,
            padding: const EdgeInsets.only(
              left: 0.8,
              right: 0.8,
              top: 0.8,
              bottom: 0.6,
            ),
            child: Icon(
                icon,
                color:
                    !activated
                        ? Colors.grey
                        : index == selectedIndex
                        ? Theme.of(context).primaryColorDark
                        : Colors.black,
              
          
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    return Column(
      children: [
        Align(alignment: Alignment.topLeft,child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(style: TextStyle(fontSize: 20.0),tabs[selectedIndex].$1),
        )),
        Container(
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1 , color: Colors.black,))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                tabs
                    .mapIndexed(
                      (index, tab) => tabBarElement(
                        index,
                        tab.$3,
                        state.backgroundImage != null || index == 0,
                      ),
                    )
                    .toList(),
          ),
        ),
    
        Expanded(child: tabs[selectedIndex].$2),
      ],
    );
  }
}

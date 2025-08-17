import 'package:flutter/material.dart';
import 'package:pic_maker/UI/custom_canvas.dart';
import 'package:pic_maker/UI/font_button.dart';
import 'package:pic_maker/UI/utilities.dart';
import 'package:provider/provider.dart';

class TextSelect extends StatefulWidget {
  const TextSelect({super.key});

  @override
  State<TextSelect> createState() => _TextSelectState();
}

class _TextSelectState extends State<TextSelect> {
  late Future<List<String>> fonts;

  @override
  void initState() {
    fonts = getAssetsPathFromPath("fonts");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    return FutureBuilder(
      future: fonts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              children:
                  snapshot.data!
                      .map(
                        (font) => FontButton(
                          fontFamily: fontFromPath(font),
                          onTap: state.addCanvasText,
                        ),
                      )
                      .toList(),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

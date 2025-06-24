import 'package:flutter/material.dart';

import 'package:pic_maker/UI/element_select.dart';
import 'package:pic_maker/UI/utilities.dart';

class BackgroundSelect extends StatefulWidget{

  const BackgroundSelect({super.key});

  @override
  State<BackgroundSelect> createState() => _BackgroundSelectState();
}

class _BackgroundSelectState extends State<BackgroundSelect> {

Future<List<String>>? futureAssets;

  @override
  Widget build(BuildContext context) {
    futureAssets ??= getAssetsPathFromPath(context, "assets/meme_templates");
    return FutureBuilder(future: futureAssets, builder: (context , snapshot) {
      if (snapshot.hasData) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            children: snapshot.data!.map((path) => ElementSelect(assetPath: path)).toList(),
                ),
        );
      }

      else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
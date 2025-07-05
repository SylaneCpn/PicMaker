import 'package:flutter/material.dart';

import 'package:pic_maker/UI/background_setter.dart';
import 'package:pic_maker/UI/utilities.dart';

class BackgroundSelect extends StatefulWidget{

  const BackgroundSelect({super.key});

  @override
  State<BackgroundSelect> createState() => _BackgroundSelectState();
}

class _BackgroundSelectState extends State<BackgroundSelect> {

late Future<List<String>> futureAssets;

@override
  void initState() {
    futureAssets = getAssetsPathFromPath("assets/meme_templates");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: futureAssets, builder: (context , snapshot) {
      if (snapshot.hasData) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            children: snapshot.data!.map((path) => BackgroundSetter(assetPath: path)).toList(),
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
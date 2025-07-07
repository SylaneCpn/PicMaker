import 'package:flutter/material.dart';
import 'package:pic_maker/UI/add_card.dart';

import 'package:pic_maker/UI/asset_button.dart';
import 'package:pic_maker/UI/custom_canvas.dart';
import 'package:pic_maker/UI/utilities.dart';
import 'package:provider/provider.dart';

class BackgroundSelect extends StatefulWidget {
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
    final state = context.read<CustomCanvasState>();
    return FutureBuilder(
      future: futureAssets,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              children: [
                AddCard(),
                ...snapshot.data!.map(
                  (path) => AssetButton(
                    assetPath: path,
                    onTap: state.setBackgroundFromAsset,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

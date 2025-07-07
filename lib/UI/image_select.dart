import 'package:flutter/material.dart';
import 'package:pic_maker/UI/add_card.dart';
import 'package:pic_maker/UI/asset_button.dart';
import 'package:pic_maker/UI/custom_canvas.dart';
import 'package:pic_maker/UI/utilities.dart';
import 'package:provider/provider.dart';

class ImageSelect extends StatefulWidget {
  const ImageSelect({super.key});

  @override
  State<ImageSelect> createState() => _ImageSelectState();
}

class _ImageSelectState extends State<ImageSelect> {
  late Future<List<String>> stickers;

  @override
  void initState() {
    stickers = getAssetsPathFromPath("assets/stickers");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CustomCanvasState>();
    return FutureBuilder(
      future: stickers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 10,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              children: [
                AddCard(onTap: state.addCustomCanvasImage),
                ...snapshot.data!.map(
                  (path) => AssetButton(
                    assetPath: path,
                    onTap: state.addAssetImageToCanvas,
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

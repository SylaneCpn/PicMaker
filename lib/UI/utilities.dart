

import 'package:flutter/services.dart';

Future<List<String>> getAssetsPathFromPath(String path) async {
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final assets = assetManifest.listAssets().where((element) => element.startsWith("assets/meme_templates/")).toList();
  return assets;
}
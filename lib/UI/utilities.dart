

import 'package:flutter/services.dart';

Future<List<String>> getAssetsPathFromPath(String path) async {
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final assets = assetManifest.listAssets().where((element) => element.startsWith(path)).toList();
  return assets;
}

String fontFromPath(String path) {
  //Last / of the path
  final woutPath = path.split("/")[1];
  //Everything before the ext
  final woutExt = woutPath.split(".")[0];
  final asFamilyWeight = woutExt.split("-");

  return asFamilyWeight[0];
}
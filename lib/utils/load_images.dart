// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/services.dart';

Future<Image> LoadImage(String asset) async {
  ByteData data = await rootBundle.load(asset);
  Codec codec =
  await instantiateImageCodec(data.buffer.asUint8List());
  FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class UIHelpers {
  UIHelpers._();

  //base64Image to file
  static File base64ToFile(String base64Image) {
    final bytes = base64Decode(base64Image);
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/temp.png');
    file.writeAsBytesSync(bytes);
    return file;
  }

  //imagePath to base64
  static String imagePathToBase64(String imagePath) {
    final bytes = File(imagePath).readAsBytesSync();
    return base64Encode(bytes);
  }
}

extension SizedBoxMaker on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

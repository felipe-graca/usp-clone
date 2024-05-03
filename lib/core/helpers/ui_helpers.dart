import 'package:flutter/material.dart';

class UIHelkpers {}

extension SizedBoxMaker on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}


import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

extension Util on BuildContext {
  MediaQueryData get info => MediaQuery.of(this);
}

extension Dimension on BuildContext {
  double get width => info.size.width;

  double getWithSize(num sizeConstant) {
    return sizeConstant != 0.0 ? ((width * (sizeConstant)) / Dimens.DESIGN_WIDTH) : 0.0;
  }
}

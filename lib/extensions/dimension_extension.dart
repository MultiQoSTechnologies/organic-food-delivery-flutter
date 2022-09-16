import 'package:flutter/material.dart';
import 'package:organic_food_app/extensions/context_extension.dart';

extension ExtNum on num {
  double toSize(BuildContext context) {
    return context.getWithSize(this);
  }
}
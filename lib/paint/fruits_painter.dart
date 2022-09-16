import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:organic_food_app/extensions/dimension_extension.dart';
import 'dart:io' show Platform;

class Pos {
  final int x, y;
  double velocity;

  Pos(this.x, this.y, this.velocity);
}

class FruitsPainter extends CustomPainter {
  FruitsPainter({
    required this.fruitDishSize,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.img,
    required this.positions,
    required this.value,
    required this.context,
  });

  final ui.Image img;
  final List<Pos> positions;
  final double fruitDishSize;
  final double value;
  final int deviceWidth, deviceHeight;
  final Paint painter = Paint();
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) async {
    final pizzaRadius = fruitDishSize / 2;
    final centerX = (deviceWidth - 10) / 2;
    var yAxisReference= 0.0;
    if (Platform.isAndroid) {
      yAxisReference= 450;
    } else if (Platform.isIOS) {
      yAxisReference= 440;
    }
    final centerY = 55.toSize(context) + ((yAxisReference.toSize(context)) / 2);

    final valueSquare = value * value;
    for (int j = 0; j < positions.length; j++) {
      final double value = valueSquare * positions[j].velocity < 1
          ? valueSquare * positions[j].velocity
          : 1;
      final double startX =
          (deviceWidth * 1.5 * (positions[j].x - centerX) / pizzaRadius) +
              centerX;
      final double startY =
          (deviceHeight * 1.5 * (positions[j].y - centerY) / pizzaRadius) +
              centerY;
      final double x2 =
          interpolate(startX, positions[j].x, value);
      final double y2 =
          interpolate(startY, positions[j].y, value);
      final inter = interpolate(1.2, 0.2, value);
      canvas.drawImageRect(
        img,
        Rect.fromLTRB(0, 0, img.width.toDouble(), img.height.toDouble()),
        Rect.fromLTRB(x2, y2, x2 + img.width * inter, y2 + img.height * inter),
        painter,
      );
    }
  }

  double interpolate(num a, num b,double progress){
    return (a - (3*progress*progress-progress-1) * (a - b));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Rect rotateRect(Rect rect, double radian) {
    final x2 = rect.left;
    final y2 = rect.top;
    rect.translate(-x2, -y2);
    return Rect.fromPoints(rotatePoint(rect.left, rect.top, radian),
        rotatePoint(rect.right, rect.bottom, radian))
      ..translate(x2, y2);
  }

  Offset rotatePoint(double x, double y, double radian) {
    return Offset(
        x * cos(radian) - y * sin(radian), x * sin(radian) + y * cos(radian));
  }
}

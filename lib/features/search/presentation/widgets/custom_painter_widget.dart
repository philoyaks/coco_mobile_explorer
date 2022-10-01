import 'dart:math';

import 'package:coco_mobile_explorer/features/search/domain/entities/search_image_model.dart';
import 'package:flutter/material.dart';

class MyCustomPainterWidget extends CustomPainter {
  final List<ImageSegmentation> segments;
  final Size originalSize;
  MyCustomPainterWidget(this.segments, this.originalSize);
  @override
  void paint(Canvas canvas, Size size) {
    Random random = Random();
    var r = (random.nextDouble() * 255).floor();
    var g = (random.nextDouble() * 255).floor();
    var b = (random.nextDouble() * 255).floor();
    final paint = Paint()
      ..strokeWidth = 3
      ..color = Color.fromARGB(30, r, g, b)
      ..style = PaintingStyle.fill;

    for (var j = 0; j < segments.length; j++) {
      var r = (Random().nextDouble() * 255).floor();
      var g = (Random().nextDouble() * 255).floor();
      var b = (Random().nextDouble() * 255).floor();

      paint.color = Color.fromRGBO(r, g, b, 0.7);

      var poly = segments[j].points;

      try {
        Path path = Path();
        Path linePath = Path();
        final borderPainter = Paint()
          ..strokeWidth = 2
          ..color = Colors.black
          ..style = PaintingStyle.stroke;

        path.moveTo(
          getActualPointX(poly[0], size, originalSize),
          getActualPointY(poly[1], size, originalSize),
        );
        linePath.moveTo(
          getActualPointX(poly[0], size, originalSize),
          getActualPointY(poly[1], size, originalSize),
        );

        for (int m = 0; m < poly.length - 2; m += 2) {
          path.lineTo(
            getActualPointX(poly[m + 2], size, originalSize),
            getActualPointY(poly[m + 3], size, originalSize),
          );
          linePath.lineTo(
            getActualPointX(poly[m + 2], size, originalSize),
            getActualPointY(poly[m + 3], size, originalSize),
          );
        }

        path.moveTo(
          getActualPointX(poly[0], size, originalSize),
          getActualPointY(poly[1], size, originalSize),
        );
        linePath.moveTo(
          getActualPointX(poly[0], size, originalSize),
          getActualPointY(poly[1], size, originalSize),
        );

        canvas.drawPath(path, paint);
        canvas.drawPath(linePath, borderPainter);
      } catch (err) {
        // dev.log(err.toString());
      }
    }
  }

  double getActualPointX(num x, Size newSize, Size oldSize) {
    return x * newSize.width / oldSize.width;
  }

  double getActualPointY(num y, Size newSize, Size oldSize) {
    return y * newSize.height / oldSize.height;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

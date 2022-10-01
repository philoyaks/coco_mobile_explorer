import 'dart:convert';

import 'package:coco_mobile_explorer/features/search/domain/entities/search_image_model.dart';
import 'package:flutter/cupertino.dart';

class SegmentedImgModel extends ImageSegmentation {
  const SegmentedImgModel({
    required int categoryId,
    required List<num> points,
  }) : super(categoryId: categoryId, points: points);

  factory SegmentedImgModel.fromJson(Map<String, dynamic> parsedJson) {
    debugPrint(parsedJson['segmentation']);

    return SegmentedImgModel(
      categoryId: parsedJson['category_id'],
      points: json.decode(parsedJson['segmentation'] ?? "[[]]") is List
          ? List<num>.from(
              (json.decode(parsedJson['segmentation'] ?? "[[]]")
                      as List<dynamic>)
                  .first,
            )
          : List<num>.from(
              json.decode(
                  parsedJson['segmentation'] ?? "{counts: []}")['counts'],
            ),
    );
  }
}

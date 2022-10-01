import 'package:coco_mobile_explorer/core/utils/image_utils.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/search_image_model.dart';
import 'custom_painter_widget.dart';

class ViewImage extends StatelessWidget {
  final String imageUrl;
  final List<ImageSegmentation> segmentation;

  const ViewImage(
      {super.key, required this.imageUrl, required this.segmentation});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppImgUtils().getImageInfo(imageUrl),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 300,
            );
          }
          return Container(
              height: 300,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: snapshot.data!.imgProvider,
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                  color: Colors.transparent,
                  child: CustomPaint(
                      foregroundPainter: MyCustomPainterWidget(
                          segmentation,
                          Size(snapshot.data!.img.width.toDouble(),
                              snapshot.data!.img.height.toDouble())))));
        });
  }
}

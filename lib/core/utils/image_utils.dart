import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:async';

class AppImgUtils {
  Future<GetSizeParameters> getImageInfo(String imageUrl) {
    NetworkImage image = NetworkImage(imageUrl);

    Completer<GetSizeParameters> completer = Completer<GetSizeParameters>();
    NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo info, bool _) =>
                completer.complete(GetSizeParameters(info.image, image)),
          ),
        );
    return completer.future;
  }
}

class GetSizeParameters {
  final ui.Image img;
  final NetworkImage imgProvider;
  GetSizeParameters(this.img, this.imgProvider);
}

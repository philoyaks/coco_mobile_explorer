import '../../domain/entities/search_image_model.dart';
import '../../domain/entities/segmented_img_entity.dart';

class SearchImgModel extends SearchImagesEntity {
  const SearchImgModel({
    required int id,
    required String cocoUrl,
    required String flickrUrl,
    required List<String> captions,
    required List<SegmentedImgModel> segmentations,
  }) : super(
          id: id,
          cocoUrl: cocoUrl,
          flickrUrl: flickrUrl,
          captions: captions,
          segmentations: segmentations,
        );

  factory SearchImgModel.fromJson(
    Map<String, dynamic> imagesJson,
    List<SegmentedImgModel> segmentations,
    List<String> captions,
  ) {
    return SearchImgModel(
      id: imagesJson['id'],
      cocoUrl: imagesJson['coco_url'],
      flickrUrl: imagesJson['flickr_url'],
      captions: captions,
      segmentations: segmentations,
    );
  }
}

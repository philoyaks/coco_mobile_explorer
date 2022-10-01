import 'package:coco_mobile_explorer/features/search/data/models/search_coco_model.dart';
import '../../domain/entities/search_results.dart';
import '../../domain/entities/segmented_img_entity.dart';

class FetchedResultModel extends SearchResultEntity {
  const FetchedResultModel({
    required List<SearchImgModel> images,
    required int total,
  }) : super(images: images, total: total);

  factory FetchedResultModel.fromJson(
    List<dynamic> imagesJson,
    List<dynamic> segmentationJson,
    List<dynamic> captionsJson, {
    int total = 5,
  }) {
    List<SearchImgModel> parsedImages = [];

    for (final image in imagesJson) {
      final segmentations = segmentationJson
          .where((element) => element['image_id'] == image['id'])
          .map((e) => SegmentedImgModel.fromJson(e))
          .toList();

      final captions = captionsJson
          .where((element) => element['image_id'] == image['id'])
          .map((e) => e['caption'].toString())
          .toList();

      parsedImages.add(SearchImgModel.fromJson(image, segmentations, captions));
    }

    return FetchedResultModel(
      images: parsedImages,
      total: total,
    );
  }

  @override
  List<Object?> get props => [images];
}

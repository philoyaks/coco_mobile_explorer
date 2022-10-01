import 'package:coco_mobile_explorer/features/search/domain/entities/search_image_model.dart';
import 'package:equatable/equatable.dart';


abstract class SearchResultEntity extends Equatable {
  final List<SearchImagesEntity> images;
  final int total;

  const SearchResultEntity({
    required this.images,
    required this.total,
  });
}

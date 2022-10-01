import 'package:coco_mobile_explorer/features/search/data/repositories/search_repo_implementation.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_response_model.dart';

class SearchService {
  final SearchRepositoryImplementation _implementation;

  SearchService(this._implementation);

  Future<ResponseModel> getImagesId(List<int> categoryIds) async {
    Map<String, dynamic> queryParams = {
      "category_ids": categoryIds,
      "querytype": "getImagesByCats",
    };
    var response = await _implementation.getImagesId(queryParams);

    int statusCode = response.statusCode ?? 000;

    debugPrint('============================>: [INFO] $response');
    debugPrint('============================>: [TYPE] ${response.runtimeType}');

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel(
          valid: true,
          message: response.data[0],
          statusCode: statusCode,
          data: response.data);
    }

    return ResponseModel(
      valid: false,
      statusCode: response.statusCode,
      message: response.data["message"],
      error: ErrorModel.fromJson(response.data),
    );
  }

  Future<dynamic> getImagesUrl(List<int> imageId) async {
    Map<String, dynamic> queryParams = {
      "image_ids": imageId,
      "querytype": "getImages",
    };
    var response = await _implementation.getImagesUrl(queryParams);

    debugPrint('============================>>>>: [INFO] $response');

    return response;
  }

  Future<dynamic> getImageSegmentation(List<int> imageId) async {
    Map<String, dynamic> queryParams = {
      "image_ids": imageId,
      "querytype": "getInstances",
    };
    var response = await _implementation.getImagesSegmentation(queryParams);
    debugPrint(
        '============================>>>>: my response[INFO] ${response.data[1]['segmentation'].runtimeType}');
    return response;
  }

  Future<dynamic> getImagesCaption(List<int> imageIds) async {
    Map<String, dynamic> queryParams = {
      "image_ids": imageIds,
      "querytype": "getCaptions",
    };
    var response = await _implementation.getImagesCaption(queryParams);

    debugPrint('============================>: [INFO] $response');

    return response;
  }
}

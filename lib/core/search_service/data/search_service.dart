import 'package:coco_mobile_explorer/core/search_service/data/search_repo_implementation.dart';
import 'package:flutter/foundation.dart';

import '../../api/api_response_model.dart';

class SearchService {
  final SearchRepositoryImplementation _implementation;

  SearchService(this._implementation);

  Future<ResponseModel<List<dynamic>>> getImagesId(
      Map<String, dynamic> query) async {
    var response = await _implementation.getImagesId(query);

    int statusCode = response.statusCode ?? 000;

    debugPrint('============================>: [INFO] $response');
    debugPrint('============================>: [TYPE] ${response.runtimeType}');

    if (statusCode >= 200 && statusCode <= 300) {
      return ResponseModel<List<dynamic>>(
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

  Future<dynamic> getImagesUrl(Map<String, dynamic> query) async {
    var response = _implementation.getImagesUrl(query);

    debugPrint('============================>>>>: [INFO] $response');

    return response;
  }

  Future<dynamic> getImageSegmentation(Map<String, dynamic> query) async {
    var response = _implementation.getImagesSegmentation(query);

    return response;
  }

  Future<dynamic> getImagesCaption(Map<String, dynamic> query) async {
    var response = _implementation.getImagesCaption(query);

    debugPrint('============================>: [INFO] $response');

    return response;
  }
}

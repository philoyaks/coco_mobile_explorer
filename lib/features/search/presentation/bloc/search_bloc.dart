import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/search_constants.dart';
import '../../data/datasources/search_service.dart';
import '../../data/models/search_results.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  int page = 1;
  List<int> categoryIds = [];
  List<int> imageIds = [];
  List<dynamic> allImageIds = [];
  List<dynamic> imagesJson = [];
  List<dynamic> segmentationJson = [];
  List<dynamic> captionsJson = [];

  final SearchService _searchService;
  int imagesperApiCalls = 0;
  SearchBloc(this._searchService) : super(SearchInitial()) {
    on<FetchSearchResults>((event, emit) async {
      if (state is SearchInitial) {
        imagesperApiCalls = 0;
      }
      emit(SearchLoading());
      var result = await _fetchresult(event.query, emit);
      if (result is String) {
        emit(SearchError(result));
        return;
      }
      page++;

      emit(SearchResult(result, page));
    });
    on<FetchMoreSearchResults>((event, emit) async {
      var currentState = state as SearchResult;
      // checks if pagination loader is already present
      if (currentState.showpaginationLoader) return;

      emit(SearchResult(currentState.searchResultsModel, currentState.page,
          showpaginationLoader: true));

      var result = await _fetchresult(event.query, emit);

      emit(SearchResult(result, page, showpaginationLoader: false));
    });
    on<StartSearchAllover>((event, emit) async {
      page = 1;
      categoryIds.clear();
      allImageIds.clear();
      imagesJson.clear();
      segmentationJson.clear();
      captionsJson.clear();

      imagesperApiCalls = 0;
      emit(SearchInitial());
    });
  }

  Future _fetchresult(String query, emit) async {
    mapIds.forEach((key, value) {
      if (query == value.toLowerCase()) {
        categoryIds.add(key);
        return;
      }
    });

    // checks if the category is valid and send as an error message to the ui
    if (categoryIds.isEmpty) {
      return 'Invalid Category';
    }

    if (allImageIds.isEmpty && categoryIds.isNotEmpty) {
      var res = await _searchService.getImagesId(categoryIds);
      if (res.valid!) {
        allImageIds = res.data;
      } else {
        return res
            .message!; // returns the error message if there is an error message while calling get images categories
      }
    }

    //turns the rest of the image ids into a list of of either 5 or the rest of the image ids if less than 5
    //helps to get accurate number to loop through
    int loop = allImageIds.length - imagesperApiCalls < 5
        ? allImageIds.length - imagesperApiCalls
        : 5;

    for (var i = imagesperApiCalls; i < imagesperApiCalls + loop; i++) {
      imageIds.add(allImageIds[i]);
    }
    imagesperApiCalls += 4;

    // determines that the image ids are valid and send as an error message to the ui
    if (imageIds.isNotEmpty) {
      late List result = [[], [], []];
      result = await Future.wait([
        _searchService.getImagesUrl(imageIds),
        _searchService.getImageSegmentation(imageIds),
        _searchService.getImagesCaption(imageIds)
      ]);
      imageIds.clear();
      imagesJson.addAll(result[0].data);
      segmentationJson.addAll(result[1].data);
      captionsJson.addAll(result[2].data);
      return FetchedResultModel.fromJson(
        imagesJson,
        segmentationJson,
        captionsJson,
        total: allImageIds.length,
      );
    } else {
      return 'No Images Found'; // returns an error of no images found if the list has ended
    }
  }
}

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
  int n = 0;
  SearchBloc(this._searchService) : super(SearchInitial()) {
    on<FetchSearchResults>((event, emit) async {
      if (state is SearchInitial) {
        n = 0;
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

      n = 0;
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

    if (allImageIds.isEmpty && categoryIds.isNotEmpty) {
      var res = await _searchService.getImagesId(categoryIds);
      if (res.valid!) {
        allImageIds = res.data;
      } else {
        return res.message!;
      }
    }
    int loop = allImageIds.length - n < 5 ? allImageIds.length - n : 5;

    for (var i = n; i < n + loop; i++) {
      imageIds.add(allImageIds[i]);
    }
    n += 4;

    late List result = [[], [], []];
    result = await Future.wait([
      _searchService.getImagesUrl(imageIds),
      _searchService.getImageSegmentation(imageIds),
      _searchService.getImagesCaption(imageIds)
    ]);

    imagesJson.addAll(result[0].data);
    segmentationJson.addAll(result[1].data);
    captionsJson.addAll(result[2].data);
    return FetchedResultModel.fromJson(
      imagesJson,
      segmentationJson,
      captionsJson,
      total: allImageIds.length,
    );
  }
}

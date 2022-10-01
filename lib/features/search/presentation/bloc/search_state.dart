// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResult extends SearchState {
  final FetchedResultModel searchResultsModel;
  final int page;
  final bool showpaginationLoader;

  const SearchResult(this.searchResultsModel, this.page,
      {this.showpaginationLoader = false});

  @override
  List<Object> get props => [searchResultsModel, showpaginationLoader];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

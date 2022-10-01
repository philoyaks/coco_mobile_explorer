part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {}

class FetchSearchResults extends SearchEvent {
  final String query;

  FetchSearchResults(this.query);

  @override
  List<Object> get props => [query];
}

class FetchMoreSearchResults extends SearchEvent {
  final String query;

  FetchMoreSearchResults(this.query);

  @override
  List<Object> get props => [query];
}

class StartSearchAllover extends SearchEvent {
  StartSearchAllover();

  @override
  List<Object> get props => [];
}

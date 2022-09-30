part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchForResult extends SearchEvent {
  final String query;

  const SearchForResult(this.query);

  @override
  List<Object> get props => [query];
}

class SearchForMore extends SearchEvent {
  final String query;

  const SearchForMore(this.query);

  @override
  List<Object> get props => [query];
}

abstract class SearchResultsEvent {}

class LoadSearchResults extends SearchResultsEvent {
  final String query;

  LoadSearchResults(this.query);
}

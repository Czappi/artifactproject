import 'package:artifactproject/src/bloc/Search/SearchQuery.dart';
import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchState {
  final SearchQuery query;
  const SearchState(this.query);
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState(query) : super(query);
}

class SearchIdleState extends SearchState {
  const SearchIdleState(query) : super(query);
}

class SearchLoadedState extends SearchState {
  final PagingController<int, MLElement> controller;
  const SearchLoadedState(this.controller, query) : super(query);
}

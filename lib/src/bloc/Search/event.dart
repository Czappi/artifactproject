import 'package:artifactproject/src/models/MNMangaPage.dart';
import 'package:artifactproject/src/utils/Enums.dart';

class SearchEvent {
  const SearchEvent();
}

class ChangeStatusEvent extends SearchEvent {
  final SearchStatus status;
  const ChangeStatusEvent(this.status);
}

class ChangeOrderEvent extends SearchEvent {
  final SearchOrderBy orderBy;
  const ChangeOrderEvent(this.orderBy);
}

class ChangeKeywordEvent extends SearchEvent {
  final SearchKeyword keyword;
  const ChangeKeywordEvent(this.keyword);
}

class ChangeSearchEvent extends SearchEvent {
  final String search;
  const ChangeSearchEvent(this.search);
}

class ChangeGenreIncludeEvent extends SearchEvent {
  final List<Genre> genreInclude;

  const ChangeGenreIncludeEvent(this.genreInclude);
}

class ChangeGenreExcludeEvent extends SearchEvent {
  final List<Genre> genreExclude;
  const ChangeGenreExcludeEvent(this.genreExclude);
}

class LoadSearchPageEvent extends SearchEvent {
  final int pageKey;
  const LoadSearchPageEvent(this.pageKey);
}

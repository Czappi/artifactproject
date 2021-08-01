import 'package:artifactproject/src/models/MNMangaPage/Genre.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:equatable/equatable.dart';

class SearchQuery extends Equatable {
  final SearchStatus status;
  final SearchOrderBy orderBy;
  final SearchKeyword keyword;
  final List<Genre> genreInclude;
  final List<Genre> genreExclude;
  final String? search;

  const SearchQuery({
    this.status = SearchStatus.both,
    this.orderBy = SearchOrderBy.latest,
    this.keyword = SearchKeyword.everything,
    this.genreInclude = const [],
    this.genreExclude = const [],
    this.search,
  });

  SearchQuery copyWith({
    SearchStatus? status,
    SearchOrderBy? orderBy,
    SearchKeyword? keyword,
    List<Genre>? genreInclude,
    List<Genre>? genreExclude,
    String? search,
  }) {
    return SearchQuery(
      status: status ?? this.status,
      orderBy: orderBy ?? this.orderBy,
      keyword: keyword ?? this.keyword,
      genreInclude: genreInclude ?? this.genreInclude,
      genreExclude: genreExclude ?? this.genreExclude,
      search: search ?? search,
    );
  }

  @override
  List<Object?> get props =>
      [status, orderBy, keyword, genreInclude, genreExclude, search];
}

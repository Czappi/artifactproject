import 'package:artifactproject/src/api/ManganatoAPI.dart';
import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'SearchQuery.dart';
import 'event.dart';
import 'state.dart';

class SearchMangaListBloc extends Bloc<SearchEvent, SearchState>
    with DiagnosticableTreeMixin {
  final PagingController<int, MLElement> pagingController =
      PagingController<int, MLElement>(firstPageKey: 1);
  BuildContext context;
  int currentPage = 0;

  List<MLElement> get items => pagingController.itemList ?? [];

  SearchQuery query = const SearchQuery();

  SearchMangaListBloc(this.context)
      : super(const SearchIdleState(SearchQuery()));

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is LoadSearchPageEvent) {
      yield SearchLoadingState(query);
      // new items
      var mp = await context.read<ManganatoAPI>().search(
            status: query.status,
            orderBy: query.orderBy,
            keyword: query.keyword,
            genreInclude: query.genreInclude,
            genreExclude: query.genreExclude,
            search: query.search,
            page: event.pageKey,
          );

      // if the last item is the same as the new last item then append an empty last page
      if (event.pageKey == mp.lastPage) {
        pagingController.appendLastPage(mp.mlElements);
      }

      // if not the last page then append the new items
      else {
        pagingController.appendPage(mp.mlElements, event.pageKey + 1);
      }

      yield SearchLoadedState(pagingController, query);
    }
    if (event is ChangeStatusEvent) {
      query = query.copyWith(status: event.status);
      pagingController.refresh();
      yield SearchIdleState(query);
    }
    if (event is ChangeOrderEvent) {
      query = query.copyWith(orderBy: event.orderBy);
      pagingController.refresh();
      yield SearchIdleState(query);
    }
    if (event is ChangeKeywordEvent) {
      query = query.copyWith(keyword: event.keyword);
      pagingController.refresh();
      yield SearchIdleState(query);
    }
    if (event is ChangeSearchEvent) {
      query = query.copyWith(search: event.search);
      pagingController.refresh();
      yield SearchIdleState(query);
    }
    if (event is ChangeGenreIncludeEvent) {
      query = query.copyWith(genreInclude: event.genreInclude);
      pagingController.refresh();
      yield SearchIdleState(query);
    }
    if (event is ChangeGenreExcludeEvent) {
      query = query.copyWith(genreExclude: event.genreExclude);
      pagingController.refresh();
      yield SearchIdleState(query);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<PagingController<int, MLElement>>(
        'pagingController', pagingController));
    properties.add(IterableProperty<MLElement>('items', items));
    properties.add(DiagnosticsProperty<SearchQuery>('query', query));
  }
}

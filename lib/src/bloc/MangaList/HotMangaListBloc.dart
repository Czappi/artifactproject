import 'package:artifactproject/src/api/ManganatoAPI.dart';
import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import 'shared/bloc.dart';
import 'shared/event.dart';
import 'shared/state.dart';

class HotMangaListBloc extends MangaListBloc {
  final PagingController<int, MLElement> pagingController =
      PagingController<int, MLElement>(firstPageKey: 1);
  BuildContext context;
  int currentPage = 0;

  HotMangaListBloc(this.context);

  @override
  Stream<MangaListState> mapEventToState(MangaListEvent event) async* {
    if (event is InitEvent) {
      pagingController.addPageRequestListener((page) {
        if (page != currentPage) {
          ++currentPage;
          add(LoadPageEvent(page));
        }
      });
    }
    if (event is LoadPageEvent) {
      // new items
      var mp = await context.read<ManganatoAPI>().hotMangaPage(event.pageKey);

      // if the last item is the same as the new last item then append an empty last page
      if (event.pageKey == mp.lastPage) {
        pagingController.appendLastPage([]);
      }

      // if not the last page then append the new items
      else {
        pagingController.appendPage(mp.mlElements, event.pageKey + 1);
      }
    }
    if (event is RefreshPageEvent) {
      yield const LoadingMLState();
      // new items
      var mp = await context
          .read<ManganatoAPI>()
          .hotMangaPage(pagingController.firstPageKey);

      // refresh to initial state
      pagingController.refresh();

      // append new first page
      pagingController.appendPage(
          mp.mlElements, pagingController.firstPageKey + 1);
    }
    yield LoadedMLState(pagingController);
  }
}

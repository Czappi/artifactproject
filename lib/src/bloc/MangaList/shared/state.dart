import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MangaListState {
  const MangaListState();
}

class LoadingMLState extends MangaListState {
  const LoadingMLState();
}

class LoadedMLState extends MangaListState {
  final PagingController<int, MLElement> controller;

  const LoadedMLState(this.controller);
}

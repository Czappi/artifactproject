class MangaListEvent {
  const MangaListEvent();
}

class LoadPageEvent extends MangaListEvent {
  final int pageKey;
  const LoadPageEvent(this.pageKey);
}

class RefreshPageEvent extends MangaListEvent {
  const RefreshPageEvent();
}

class InitEvent extends MangaListEvent {
  const InitEvent();
}

class MangaPageEvent {
  const MangaPageEvent();
}

class LoadMPEvent extends MangaPageEvent {
  final String url;

  const LoadMPEvent(this.url);
}

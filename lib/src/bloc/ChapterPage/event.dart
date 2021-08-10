class ChapterPageEvent {
  const ChapterPageEvent();
}

class LoadCHPEvent extends ChapterPageEvent {
  final String url, title;

  const LoadCHPEvent(
    this.url,
    this.title,
  );
}

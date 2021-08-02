class MangaPageEvent {
  const MangaPageEvent();
}

class LoadMPEvent extends MangaPageEvent {
  final String url, title, author, imgUrl;
  final double rating;

  const LoadMPEvent(
      this.url, this.title, this.author, this.imgUrl, this.rating);
}

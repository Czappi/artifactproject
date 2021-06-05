import 'package:equatable/equatable.dart';
import 'package:artifactproject/src/models/MNMangaListPage.dart' show Chapter;

class Bookmark extends Equatable {
  final String title, url, imgUrl, id;
  final Chapter latestChapter, lastViewedChapter;

  const Bookmark({
    required this.title,
    required this.url,
    required this.id,
    required this.imgUrl,
    required this.latestChapter,
    required this.lastViewedChapter,
  });

  @override
  List<Object?> get props =>
      [title, url, id, imgUrl, latestChapter.props, lastViewedChapter.props];
}

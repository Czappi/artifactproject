import 'package:artifactproject/src/models/MNMangaListPage/Chapter.dart';
import 'package:equatable/equatable.dart';

class MLElement extends Equatable {
  final String title, imgUrl, author, url, descriptionPiece;
  final DateTime updated;
  final double ratingAverage;
  final int views;
  final Chapter? latestChapter;

  const MLElement({
    required this.title,
    required this.author,
    required this.imgUrl,
    required this.url,
    required this.descriptionPiece,
    required this.updated,
    required this.ratingAverage,
    required this.views,
    required this.latestChapter,
  });

  @override
  List<Object?> get props => [
        title,
        imgUrl,
        author,
        url,
        descriptionPiece,
        updated,
        ratingAverage,
        views,
        latestChapter
      ];
}

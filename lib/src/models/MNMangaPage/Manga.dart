import 'package:artifactproject/src/models/MNMangaPage/Rating.dart';
import 'package:artifactproject/src/models/MNMangaPage/Author.dart';
import 'package:artifactproject/src/models/MNMangaPage/Chapter.dart';
import 'package:artifactproject/src/models/MNMangaPage/Genre.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:equatable/equatable.dart';

class Manga extends Equatable {
  final String title, href, img, alternativeTitle;
  final Author author;
  final MangaStatus status;
  final List<Genre> genres;
  final DateTime updated;
  final int view;
  final Rating rating;

  // used for bookmark and rate
  final String postId;

  final String description;
  final List<Chapter> chapters;

  const Manga({
    required this.title,
    required this.href,
    required this.img,
    required this.alternativeTitle,
    required this.author,
    required this.status,
    required this.genres,
    required this.updated,
    required this.view,
    required this.rating,
    required this.postId,
    required this.description,
    required this.chapters,
  });

  @override
  List<Object> get props => [
        title,
        href,
        img,
        alternativeTitle,
        author.props,
        status,
        genres,
        updated,
        view,
        rating.props,
        postId,
        description,
        chapters,
      ];
}

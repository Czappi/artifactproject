import 'package:artifactproject/src/models/MNMangaPage/Rating.dart';
import 'package:artifactproject/src/models/MNMangaPage/Author.dart';
import 'package:artifactproject/src/models/MNMangaPage/Chapter.dart';
import 'package:artifactproject/src/models/MNMangaPage/Genre.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:equatable/equatable.dart';

class Manga extends Equatable {
  final String title, href, img;
  final String? alternativeTitle;
  final Author author;
  final MangaStatus? status;
  final List<Genre>? genres;
  final DateTime? updated;
  final int? view;
  final Rating rating;
  final bool? followed;

  // used for bookmark and rate
  final String? postId;

  final String? description;
  final List<Chapter>? chapters;

  const Manga({
    required this.title,
    required this.href,
    required this.img,
    this.alternativeTitle,
    required this.author,
    this.status,
    this.genres,
    this.updated,
    this.view,
    required this.rating,
    this.postId,
    this.description,
    this.chapters,
    this.followed,
  });

  @override
  List<Object?> get props => [
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

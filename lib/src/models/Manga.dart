import 'package:artifactproject/src/models/Author.dart';
import 'package:artifactproject/src/models/Chapter.dart';
import 'package:artifactproject/src/models/Genre.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:equatable/equatable.dart';

class Manga extends Equatable {
  final String title;
  final String href;
  final String img;
  final Author author;
  final MangaStatus status;
  final List<Genre> genres;
  final DateTime updated;
  final int view;
  final double rating;

  final String bookmarkId;

  final String description;
  final List<Chapter> chapters;

  const Manga({
    required this.title,
    required this.href,
    required this.img,
    required this.author,
    required this.status,
    required this.genres,
    required this.updated,
    required this.view,
    required this.rating,
    required this.bookmarkId,
    required this.description,
    required this.chapters,
  });

  @override
  List<Object> get props =>
      [title, href, img, author, status, genres, updated, view, rating];
}

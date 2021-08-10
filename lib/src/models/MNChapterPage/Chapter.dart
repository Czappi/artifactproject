import 'package:artifactproject/src/models/MNChapterPage/ChapterList.dart';
import 'package:artifactproject/src/models/MNChapterPage/ImageServer.dart';
import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  final String title, href;
  final String? prevHref, nextHref;
  final List<String>? imageUrls;
  final ImageServer? currentImageServer, otherImageServer;
  final ChapterList? chapterList;

  const Chapter({
    required this.title,
    required this.href,
    this.nextHref,
    this.prevHref,
    this.imageUrls,
    this.currentImageServer,
    this.otherImageServer,
    this.chapterList,
  });

  @override
  List<Object?> get props => [
        title,
        href,
        imageUrls,
        prevHref,
        nextHref,
        currentImageServer?.props,
        otherImageServer?.props,
        chapterList?.props,
      ];
}

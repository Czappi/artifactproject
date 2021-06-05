import 'package:equatable/equatable.dart';
import 'package:artifactproject/src/models/MNLogin.dart';

class BookmarkPage extends Equatable {
  final List<Bookmark> bookmarks;
  final int currentPage, lastPage;

  const BookmarkPage({
    required this.currentPage,
    required this.lastPage,
    required this.bookmarks,
  });

  @override
  List<Object?> get props => [currentPage, lastPage, bookmarks];
}

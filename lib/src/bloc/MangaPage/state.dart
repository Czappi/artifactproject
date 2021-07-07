import 'package:artifactproject/src/models/MNMangaPage.dart';

class MangaPageState {
  final Manga? manga;
  const MangaPageState({this.manga});
}

class LoadingMPState extends MangaPageState {
  const LoadingMPState({manga}) : super(manga: manga);
}

class LoadedMPState extends MangaPageState {
  const LoadedMPState(manga) : super(manga: manga);
}

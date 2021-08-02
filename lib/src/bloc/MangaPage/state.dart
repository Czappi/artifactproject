import 'package:artifactproject/src/models/MNMangaPage.dart';

class MangaPageState {
  final Manga manga;
  const MangaPageState(this.manga);
}

class InitialMPState extends MangaPageState {
  const InitialMPState()
      : super(
          const Manga(
            title: "",
            href: "",
            img: "",
            author: Author("", null),
            rating: Rating(0, null, null),
          ),
        );
}

class LoadingMPState extends MangaPageState {
  const LoadingMPState(manga) : super(manga);
}

class LoadedMPState extends MangaPageState {
  const LoadedMPState(manga) : super(manga);
}

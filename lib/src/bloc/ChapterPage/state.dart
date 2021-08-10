import 'package:artifactproject/src/models/MNChapterPage.dart';

class ChapterPageState {
  final Chapter chapter;
  const ChapterPageState(this.chapter);
}

class InitialCHPState extends ChapterPageState {
  const InitialCHPState()
      : super(
          const Chapter(title: "", href: ""),
        );
}

class LoadingCHPState extends ChapterPageState {
  const LoadingCHPState(manga) : super(manga);
}

class LoadedCHPState extends ChapterPageState {
  const LoadedCHPState(manga) : super(manga);
}

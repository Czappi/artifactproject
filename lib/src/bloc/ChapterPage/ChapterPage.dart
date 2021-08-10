import 'package:artifactproject/src/api/ManganatoAPI.dart';
import 'package:artifactproject/src/models/MNChapterPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';
import 'event.dart';

export 'state.dart';
export 'event.dart';

class ChapterPageBloc extends Bloc<ChapterPageEvent, ChapterPageState> {
  BuildContext context;
  ChapterPageBloc(this.context) : super(const InitialCHPState());

  @override
  Stream<ChapterPageState> mapEventToState(ChapterPageEvent event) async* {
    if (event is LoadCHPEvent) {
      yield const InitialCHPState();
      var initialChapter = Chapter(title: event.title, href: event.url);

      yield LoadingCHPState(initialChapter);

      var chapter = await context.read<ManganatoAPI>().chapterPage(event.url);

      if (event.url == chapter.href && state.chapter != chapter) {
        yield LoadedCHPState(chapter);
      }
    }
  }
}

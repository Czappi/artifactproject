import 'package:artifactproject/src/api/ManganatoAPI.dart';
import 'package:artifactproject/src/models/MNMangaPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';
import 'event.dart';

export 'state.dart';
export 'event.dart';

class MangaPageBloc extends Bloc<MangaPageEvent, MangaPageState> {
  BuildContext context;
  MangaPageBloc(this.context) : super(const InitialMPState());

  @override
  Stream<MangaPageState> mapEventToState(MangaPageEvent event) async* {
    if (event is LoadMPEvent) {
      yield const InitialMPState();
      var initialManga = Manga(
        href: event.url,
        title: event.title,
        author: Author(event.author, null),
        img: event.imgUrl,
        rating: Rating(event.rating, null, null),
      );

      yield LoadingMPState(initialManga);

      var manga = await context.read<ManganatoAPI>().mangaPage(event.url);

      if (event.url == manga.href && state.manga != manga) {
        yield LoadedMPState(manga);
      }
    }
  }
}

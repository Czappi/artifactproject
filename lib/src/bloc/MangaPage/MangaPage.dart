import 'package:artifactproject/src/api/ManganatoAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';
import 'event.dart';

export 'state.dart';
export 'event.dart';

class MangaPageBloc extends Bloc<MangaPageEvent, MangaPageState> {
  BuildContext context;
  MangaPageBloc(this.context) : super(const LoadingMPState());

  @override
  Stream<MangaPageState> mapEventToState(MangaPageEvent event) async* {
    if (event is LoadMPEvent) {
      yield const LoadingMPState();
      var manga = await context.read<ManganatoAPI>().mangaPage(event.url);

      if (state.manga != manga) {
        yield LoadedMPState(manga);
      }
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';

abstract class MangaListBloc extends Bloc<MangaListEvent, MangaListState> {
  MangaListBloc() : super(const LoadingMLState());

  @override
  Stream<MangaListState> mapEventToState(MangaListEvent event);
}

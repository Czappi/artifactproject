import 'package:artifactproject/src/bloc/MangaList/shared/bloc.dart';
import 'package:artifactproject/src/bloc/MangaList/shared/event.dart';
import 'package:artifactproject/src/bloc/MangaList/shared/state.dart';
import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:artifactproject/src/utils/builders.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';

class MLList<MLBloc extends MangaListBloc> extends StatelessWidget {
  final MLItemBuilder builder;
  const MLList({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<MLBloc>(context, listen: false)
          .add(const RefreshPageEvent()),
      child: BlocBuilder<MLBloc, MangaListState>(
        builder: (context, state) {
          if (state is LoadedMLState) {
            return PagedListView<int, MLElement>(
              pagingController: state.controller,
              builderDelegate: PagedChildBuilderDelegate<MLElement>(
                  itemBuilder: (context, item, index) => builder(context, item),
                  newPageProgressIndicatorBuilder: (context) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: context.atheme.buttonColor,
                        ),
                      ),
                    );
                  }),
            );
          }
          if (state is LoadingMLState) {
            return CircularProgressIndicator(
              color: context.atheme.buttonColor,
            );
          }

          return Container();
        },
      ),
    );
  }
}

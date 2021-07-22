import 'package:artifactproject/src/bloc/MangaList/shared/bloc.dart';
import 'package:artifactproject/src/bloc/MangaList/shared/event.dart';
import 'package:artifactproject/src/bloc/MangaList/shared/state.dart';
import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:artifactproject/src/utils/builders.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';

class MLGrid<MLBloc extends MangaListBloc> extends StatelessWidget {
  final MLItemBuilder builder;
  final int crossAxisCount;
  final double childAspectRatio;
  const MLGrid({
    Key? key,
    required this.builder,
    this.childAspectRatio = 1 / 1.78,
    this.crossAxisCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<MLBloc>(context, listen: false)
          .add(const RefreshPageEvent()),
      child: BlocBuilder<MLBloc, MangaListState>(
        builder: (context, state) {
          if (state is LoadedMLState) {
            return PagedGridView<int, MLElement>(
              pagingController: state.controller,
              builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, element, index) =>
                      builder(context, element)),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.78,
              ),
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

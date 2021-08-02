import 'package:artifactproject/src/bloc/Search/SearchMangaListBloc.dart';
import 'package:artifactproject/src/bloc/Search/event.dart';
import 'package:artifactproject/src/bloc/Search/state.dart';
import 'package:artifactproject/src/models/MNMangaListPage/MangaListElement.dart';
import 'package:artifactproject/src/models/MNMangaPage/Genre.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:artifactproject/src/widgets/MLListBigItem.dart';
import 'package:artifactproject/src/widgets/MLListVerticalItem.dart';
import 'package:artifactproject/src/widgets/SearchAppbar.dart';
import 'package:artifactproject/src/widgets/SearchFilter.dart';
import 'package:artifactproject/src/widgets/SearchGenreFilterGroup.dart';
import 'package:artifactproject/src/widgets/SearchSingleChoiceFilterGroup.dart';
import 'package:flutter/material.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => PanelController(),
      builder: (context, _) => BlocProvider(
        create: (context) => SearchMangaListBloc(context),
        child: Scaffold(
          backgroundColor: context.atheme.backgroundColor,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: context.atheme.systemUiOverlayStyle,
            child: SafeArea(
              child: Container(
                color: context.atheme.backgroundColor,
                child: Column(
                  children: [
                    const _SearchBar(),
                    Expanded(
                      child: SlidingUpPanel(
                        controller: context.watch<PanelController>(),
                        maxHeight: 628.h,
                        minHeight: 0,
                        color: context.atheme.cardColor,
                        borderRadius: context.atheme.standardBorderRadius,
                        panel: const _Filters(),
                        body: const _Results(),
                        collapsed: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  late TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMangaListBloc, SearchState>(
        buildWhen: (previous, current) =>
            previous.query.search != current.query.search,
        builder: (context, state) {
          textEditingController =
              TextEditingController(text: state.query.search);
          return SearchAppbar(
            textEditingController: textEditingController,
            filterOnTap: () async {
              await context.read<PanelController>().show();
              await context.read<PanelController>().open();
            },
            searchOnTap: () {
              context.read<SearchMangaListBloc>().add(
                    ChangeSearchEvent(
                      textEditingController.value.text,
                    ),
                  );
              context
                  .read<SearchMangaListBloc>()
                  .add(const LoadSearchPageEvent(1));
              FocusScope.of(context).unfocus();
            },
            onSubmitted: (text) {
              context.read<SearchMangaListBloc>().add(ChangeSearchEvent(text));
              context
                  .read<SearchMangaListBloc>()
                  .add(const LoadSearchPageEvent(1));
              FocusScope.of(context).unfocus();
            },
          );
          /*
          return SizedBox(
            height: 60.h,
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      PhosphorIcons.caretLeftBold,
                      size: 26.sp,
                      color: context.atheme.iconColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: context.atheme.cardColor,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: context.atheme.standardBorderRadius,
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (text) {
                        context
                            .read<SearchMangaListBloc>()
                            .add(ChangeSearchEvent(text));
                        context
                            .read<SearchMangaListBloc>()
                            .add(const LoadSearchPageEvent(1));
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await context.read<PanelController>().show();
                        await context.read<PanelController>().open();
                      },
                      icon: Icon(
                        PhosphorIcons.slidersHorizontalBold,
                        size: 26.sp,
                        color: context.atheme.iconColor,
                      )),
                  IconButton(
                      onPressed: () {
                        context.read<SearchMangaListBloc>().add(
                              ChangeSearchEvent(
                                textEditingController.value.text,
                              ),
                            );
                        context
                            .read<SearchMangaListBloc>()
                            .add(const LoadSearchPageEvent(1));
                        FocusScope.of(context).unfocus();
                      },
                      icon: Icon(
                        PhosphorIcons.magnifyingGlassBold,
                        size: 26.sp,
                        color: context.atheme.iconColor,
                      )),
                ],
              ),
            ),
          );
          */
        });
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.all(10.sp),
            height: 6.h,
            width: 35.w,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: context.atheme.standardBorderRadius),
          ),
        ),
        BlocBuilder<SearchMangaListBloc, SearchState>(
            buildWhen: (previous, current) =>
                previous.query.status != current.query.status,
            builder: (context, state) {
              return SearchSingleChoiceFilterGroup(
                title: "#status".tr.capitalizeFirst!,
                filters: [
                  SearchFilter(label: "#status-completed".tr.capitalizeFirst!),
                  SearchFilter(label: "#status-ongoing".tr.capitalizeFirst!),
                  SearchFilter(
                      label: "#status-ongoing".tr.capitalizeFirst! +
                          " " +
                          "#and".tr +
                          " " +
                          "#status-completed".tr.capitalizeFirst!),
                ],
                onSelect: (i) {
                  context
                      .read<SearchMangaListBloc>()
                      .add(ChangeStatusEvent(SearchStatus.values[i]));
                },
                selected: state.query.status.index,
              );
            }),
        BlocBuilder<SearchMangaListBloc, SearchState>(
            buildWhen: (previous, current) =>
                previous.query.orderBy != current.query.orderBy,
            builder: (context, state) {
              return SearchSingleChoiceFilterGroup(
                title: "#orderby".tr.capitalizeFirst!,
                filters: [
                  SearchFilter(label: "#latest".tr.capitalizeFirst!),
                  SearchFilter(label: "#mostviewed".tr.capitalizeFirst!),
                  SearchFilter(label: "#newest".tr.capitalizeFirst!),
                  const SearchFilter(label: "A-Z"),
                ],
                onSelect: (i) {
                  context
                      .read<SearchMangaListBloc>()
                      .add(ChangeOrderEvent(SearchOrderBy.values[i]));
                },
                selected: state.query.orderBy.index,
              );
            }),
        BlocBuilder<SearchMangaListBloc, SearchState>(
            buildWhen: (previous, current) =>
                previous.query.keyword != current.query.keyword,
            builder: (context, state) {
              return SearchSingleChoiceFilterGroup(
                title: "#keywords".tr.capitalizeFirst!,
                filters: [
                  SearchFilter(
                      label: "#keyword-everything".tr.capitalizeFirst!),
                  SearchFilter(label: "#keyword-nameTitle".tr.capitalizeFirst!),
                  SearchFilter(
                      label: "#keyword-alternativeName".tr.capitalizeFirst!),
                  SearchFilter(label: "#keyword-author".tr.capitalizeFirst!),
                ],
                onSelect: (i) {
                  context
                      .read<SearchMangaListBloc>()
                      .add(ChangeKeywordEvent(SearchKeyword.values[i]));
                },
                selected: state.query.keyword.index,
              );
            }),
        BlocBuilder<SearchMangaListBloc, SearchState>(
            buildWhen: (previous, current) =>
                previous.query.genreInclude != current.query.genreInclude,
            builder: (context, state) {
              return SearchGenreFilterGroup(
                  title: "#genreinclude".tr.capitalizeFirst!,
                  genres: Genre.genres,
                  selected: state.query.genreInclude,
                  onSelect: (genres) {
                    context
                        .read<SearchMangaListBloc>()
                        .add(ChangeGenreIncludeEvent(genres));
                  });
            }),
        BlocBuilder<SearchMangaListBloc, SearchState>(
            buildWhen: (previous, current) =>
                previous.query.genreExclude != current.query.genreExclude,
            builder: (context, state) {
              return SearchGenreFilterGroup(
                  title: "#genreexclude".tr.capitalizeFirst!,
                  genres: Genre.genres,
                  selected: state.query.genreExclude,
                  onSelect: (genres) {
                    context
                        .read<SearchMangaListBloc>()
                        .add(ChangeGenreExcludeEvent(genres));
                  });
            }),
      ],
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMangaListBloc, SearchState>(
        //buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
      if (state is SearchLoadedState) {
        return Selector<SettingsProvider, DiscoverLayoutOption>(
            selector: (context, provider) => provider.discoverStyle,
            builder: (context, option, child) {
              if (option == DiscoverLayoutOption.list) {
                return PagedListView<int, MLElement>(
                  shrinkWrap: true,
                  pagingController: state.controller,
                  builderDelegate: PagedChildBuilderDelegate<MLElement>(
                      itemBuilder: (context, item, index) {
                    return MLListBigItem(mlElement: item);
                  }, newPageProgressIndicatorBuilder: (context) {
                    return SizedBox(
                      height: 100.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: context.atheme.buttonColor,
                        ),
                      ),
                    );
                  }),
                );
              }
              return PagedGridView<int, MLElement>(
                pagingController: state.controller,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, element, index) =>
                      MLListVerticalItem(mlElement: element),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1.78,
                ),
              );
            });
      }
      if (state is SearchLoadingState) {
        return Center(
          child: CircularProgressIndicator(
            color: context.atheme.buttonColor,
          ),
        );
      }
      return Container();
    });
  }
}

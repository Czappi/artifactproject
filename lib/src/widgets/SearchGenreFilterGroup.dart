import 'package:artifactproject/src/models/MNMangaPage/Genre.dart';
import 'package:artifactproject/src/widgets/SearchFilter.dart';
import 'package:artifactproject/src/widgets/shared/BulkGrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';

class SearchGenreFilterGroup extends StatefulWidget {
  final List<Genre> genres;
  final String title;
  final List<Genre> selected;
  final Function(List<Genre>) onSelect;
  const SearchGenreFilterGroup({
    Key? key,
    required this.title,
    required this.genres,
    required this.selected,
    required this.onSelect,
  }) : super(key: key);

  @override
  _SearchGenreFilterGroupState createState() => _SearchGenreFilterGroupState();
}

class _SearchGenreFilterGroupState extends State<SearchGenreFilterGroup> {
  List<Genre> genres = [];

  @override
  void initState() {
    genres.addAll(widget.selected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.sp, bottom: 5.sp),
                  child: Text(
                    widget.title,
                    style: context.atheme.mltitleTextStyle
                        .copyWith(fontSize: 16.sp),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(4.sp),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        genres.clear();
                      });
                    },
                    child: Text(
                      "#removeall".tr.capitalizeFirst!,
                      style: context.atheme.mlsubtitleTextStyle
                          .copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
          BulkGrid(
            crossAxisCount: 3,
            children: List.generate(widget.genres.length, (index) {
              var genre = widget.genres[index];
              var isSelected = widget.selected.contains(genre);
              return SearchFilter(
                label: genre.name.tr.capitalizeFirst!,
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      genres.add(genre);
                      widget.onSelect.call(genres);
                    } else {
                      genres.remove(genre);
                      widget.onSelect.call(genres);
                    }
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:artifactproject/src/widgets/SearchFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';

class SearchSingleChoiceFilterGroup extends StatefulWidget {
  final List<SearchFilter> filters;
  final String title;
  final int selected;
  final Function(int) onSelect;
  const SearchSingleChoiceFilterGroup({
    Key? key,
    required this.title,
    required this.filters,
    required this.selected,
    required this.onSelect,
  }) : super(key: key);
  @override
  State<SearchSingleChoiceFilterGroup> createState() =>
      _SearchSingleChoiceFilterGroupState();
}

class _SearchSingleChoiceFilterGroupState
    extends State<SearchSingleChoiceFilterGroup> {
  int? selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.sp),
            child: Text(
              widget.title,
              style: context.atheme.mltitleTextStyle.copyWith(fontSize: 16.sp),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.filters.length,
              itemBuilder: (context, index) {
                var sf = widget.filters[index];
                return SearchFilter(
                  label: sf.label,
                  selected: sf.selected ?? selectedIndex == index,
                  onSelected: sf.onSelected ??
                      (selected) {
                        widget.onSelect.call(index);
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

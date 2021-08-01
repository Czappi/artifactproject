import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFilter extends StatelessWidget {
  final String label;
  final ValueChanged<bool>? onSelected;
  final bool? selected;
  const SearchFilter(
      {Key? key, required this.label, this.selected, this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.sp, right: 4.sp),
      child: FilterChip(
        label: Text(label),
        selected: selected ?? false,
        onSelected: onSelected,
      ),
    );
  }
}

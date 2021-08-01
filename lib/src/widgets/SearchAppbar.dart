import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';

class SearchAppbar extends StatelessWidget {
  final TextEditingController textEditingController;
  final GestureTapCallback? searchOnTap, filterOnTap;
  final ValueChanged<String>? onSubmitted;
  const SearchAppbar({
    Key? key,
    required this.textEditingController,
    this.filterOnTap,
    this.searchOnTap,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onSubmitted: onSubmitted,
              ),
            ),
            IconButton(
                onPressed: filterOnTap,
                icon: Icon(
                  PhosphorIcons.slidersHorizontalBold,
                  size: 26.sp,
                  color: context.atheme.iconColor,
                )),
            IconButton(
                onPressed: searchOnTap,
                icon: Icon(
                  PhosphorIcons.magnifyingGlassBold,
                  size: 26.sp,
                  color: context.atheme.iconColor,
                )),
          ],
        ),
      ),
    );
  }
}

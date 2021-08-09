import 'package:artifactproject/src/models/MNMangapage.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:artifactproject/src/widgets/MangapageChapter.dart';
import 'package:artifactproject/src/widgets/shared/MangapageCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MangapageChaptersCard extends StatelessWidget {
  final List<Chapter> chapters;
  const MangapageChaptersCard({
    Key? key,
    required this.chapters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MangapageCard(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 600.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "#chapters".tr.capitalize!,
              style: context.atheme.bodyTitleTextStyle,
            ),
            SizedBox(
              height: 12.h,
            ),
            _ChapterList(
              chapters: chapters,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChapterList extends StatelessWidget {
  final List<Chapter> chapters;
  const _ChapterList({
    Key? key,
    required this.chapters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return MangapageChapter(
            chapter: chapters[index],
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: context.atheme.bodySubtitleTextStyle.color,
        ),
      ),
    );
  }
}

import 'package:artifactproject/src/bloc/ChapterPage/ChapterPage.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:artifactproject/src/ui/Chapterpage.dart';
import 'package:artifactproject/src/utils/DateTimePrint.dart';
import 'package:flutter/material.dart';
import 'package:artifactproject/src/models/MNMangaPage.dart';
import 'package:get/get.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class MangapageChapter extends StatelessWidget {
  final Chapter chapter;
  const MangapageChapter({
    Key? key,
    required this.chapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context
              .read<ChapterPageBloc>()
              .add(LoadCHPEvent(chapter.href, chapter.title));
          Get.to(() => Chapterpage());
        },
        onLongPress: () {},
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  chapter.title,
                  overflow: TextOverflow.ellipsis,
                  style: context.atheme.bodyTextStyle,
                ),
              ),
              Text(
                DateTimePrint.parse(chapter.uploaded),
                overflow: TextOverflow.clip,
                style: context.atheme.bodyTextStyle.copyWith(
                  color: context.atheme.bodyTextStyle.color!.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

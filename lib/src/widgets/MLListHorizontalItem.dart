import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:artifactproject/src/providers/NavigationProvider.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class MLListHorizontalItem extends StatelessWidget {
  final MLElement mlElement;
  final MLListItemDetailsType type;
  final double? width, height;
  final double aspectRatio;
  const MLListHorizontalItem(
      {Key? key,
      required this.mlElement,
      this.height,
      this.width,
      this.aspectRatio = 348 / 225,
      this.type = MLListItemDetailsType.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MLListHorizontalItemImage(
            img: NetworkImage(mlElement.imgUrl),
            aspectRatio: aspectRatio,
          ),
          _MLListHorizontalItemDetails(
            type: type,
            author: mlElement.author,
            latestChapter: (mlElement.latestChapter != null)
                ? mlElement.latestChapter!.title
                : "",
            ratingAverage: mlElement.ratingAverage,
            title: mlElement.title,
          ),
        ],
      ),
    );
  }
}

class _MLListHorizontalItemDetails extends StatelessWidget {
  final MLListItemDetailsType type;
  final String latestChapter, author, title;
  final double ratingAverage;
  const _MLListHorizontalItemDetails({
    Key? key,
    this.type = MLListItemDetailsType.none,
    required this.title,
    required this.author,
    required this.latestChapter,
    required this.ratingAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? secondRow;

    switch (type) {
      case MLListItemDetailsType.author:
        secondRow = Text(
          author,
          style: context.atheme.mlsubtitleTextStyle.copyWith(fontSize: 11.sp),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
        break;
      case MLListItemDetailsType.latestChapter:
        secondRow = Text(
          latestChapter,
          style: context.atheme.mlsubtitleTextStyle.copyWith(fontSize: 11.sp),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
        break;
      case MLListItemDetailsType.rating:
        secondRow = Row(
          children: [
            Text(
              ratingAverage.toString(),
              style:
                  context.atheme.mlsubtitleTextStyle.copyWith(fontSize: 11.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Icon(
              PhosphorIcons.starFill,
              color: context.atheme.starColor,
              size: 12.sp,
            )
          ],
        );
        break;
      default:
        secondRow = const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5.h,
        ),
        Text(
          title,
          style: context.atheme.mltitleTextStyle.copyWith(fontSize: 13.sp),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        secondRow,
      ],
    );
  }
}

class _MLListHorizontalItemImage extends StatelessWidget {
  final ImageProvider img;
  final double aspectRatio;
  const _MLListHorizontalItemImage({
    Key? key,
    required this.img,
    required this.aspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: context.atheme.standardBorderRadius,
        ),
        child: ClipRRect(
          borderRadius: context.atheme.standardBorderRadius,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image(
                  image: img,
                  fit: BoxFit.fitWidth,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      //context.read<NavigationProvider>().navigateTo(mlElement.url);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

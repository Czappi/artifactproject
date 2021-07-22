import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:artifactproject/src/providers/NavigationProvider.dart';
import 'package:artifactproject/src/utils/Enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class MLListVerticalItem extends StatelessWidget {
  final MLElement mlElement;
  final MLListItemDetailsType type;
  final double? width, height;
  final double aspectRatio;
  const MLListVerticalItem(
      {Key? key,
      required this.mlElement,
      this.width,
      this.height,
      this.aspectRatio = 225 / 348,
      this.type = MLListItemDetailsType.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.read<NavigationProvider>().navigateTo(mlElement.url);
            },
            child: _MLListVerticalItemImage(
              img: NetworkImage(mlElement.imgUrl),
              aspectRatio: aspectRatio,
            ),
          ),
          _MLListVerticalItemDetails(
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

class _MLListVerticalItemDetails extends StatelessWidget {
  final MLListItemDetailsType type;
  final String latestChapter, author, title;
  final double ratingAverage;
  const _MLListVerticalItemDetails({
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

class _MLListVerticalItemImage extends StatelessWidget {
  final ImageProvider img;
  final double aspectRatio;
  const _MLListVerticalItemImage({
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
                  fit: BoxFit.fitHeight,
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

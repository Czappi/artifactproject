import 'package:artifactproject/src/models/MNMangaListPage.dart';
import 'package:artifactproject/src/providers/NavigationProvider.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:artifactproject/src/widgets/shared/BluredImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as g;

class MLListItem extends StatelessWidget {
  final MLElement mlElement;
  const MLListItem({Key? key, required this.mlElement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = NetworkImage(mlElement.imgUrl);
    return InkWell(
      onTap: () {
        context.read<NavigationProvider>().navigateTo(mlElement.url);
      },
      child: Container(
        margin: EdgeInsets.all(10.sp),
        height: 220.h,
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            ClipRRect(
              borderRadius: context.atheme.standardBorderRadius,
              child: BluredImage(
                image: image,
                blurColor: Colors.black.withOpacity(0.4),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18.sp),
              child: Row(
                children: [
                  Expanded(
                    child: _MLListItemDetails(
                        title: mlElement.title,
                        author: mlElement.author,
                        description: mlElement.descriptionPiece),
                  ),
                  _MLListItemImage(img: image),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MLListItemDetails extends StatelessWidget {
  final String title, author, description;

  const _MLListItemDetails({
    Key? key,
    required this.title,
    required this.author,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.sp),
          child: Text(
            title,
            style: context.atheme.mltitleTextStyle,
            maxLines: 2,
            overflow: TextOverflow.fade,
          ),
        ),
        Text(
          author,
          style: context.atheme.mlsubtitleTextStyle.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: EdgeInsets.only(right: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#description'.tr.capitalizeFirst!,
                style: context.atheme.mlsubtitleTextStyle.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFE1E2E8),
                ),
              ),
              Text(
                description + '...',
                style: context.atheme.mlsubtitleTextStyle,
                maxLines: 3,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MLListItemImage extends StatelessWidget {
  final ImageProvider img;
  const _MLListItemImage({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 225 / 348,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: context.atheme.standardBorderRadius,
        ),
        padding: EdgeInsets.all(2.sp),
        child: ClipRRect(
          borderRadius: context.atheme.standardBorderRadius,
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
      ),
    );
  }
}

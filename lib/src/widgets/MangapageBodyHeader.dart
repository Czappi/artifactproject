import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:get/get.dart';

class MangapageBodyHeader extends StatelessWidget {
  final String title, author, imgUrl;
  final double rating;
  final bool? followed;
  const MangapageBodyHeader({
    Key? key,
    required this.title,
    required this.author,
    required this.imgUrl,
    required this.rating,
    required this.followed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.atheme.backgroundColor,
      margin: EdgeInsets.fromLTRB(12.sp, 6.sp, 0, 12.sp),
      height: 175.h,
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            _Image(
              img: NetworkImage(imgUrl),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Title(
                    title: title,
                  ),
                  _Subtitle(
                    subtitle: author,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _Rating(
                        rating: rating,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _ButtonRow(
                      followed: followed,
                      readOnTap: () {},
                      bookmarkOnTap: () {},
                      shareOnTap: () {},
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.atheme.titleTextStyle,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Subtitle extends StatelessWidget {
  final String subtitle;
  const _Subtitle({
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: context.atheme.subtitleTextStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _Rating extends StatelessWidget {
  final double rating;
  const _Rating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          PhosphorIcons.starFill,
          color: context.atheme.starColor,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          rating.toString(),
          style: context.atheme.bodyTitleTextStyle.copyWith(fontSize: 16.sp),
        )
      ],
    );
  }
}

class _ButtonRow extends StatelessWidget {
  final GestureTapCallback? readOnTap, bookmarkOnTap, shareOnTap;
  final bool? followed;
  const _ButtonRow({
    Key? key,
    this.readOnTap,
    this.bookmarkOnTap,
    this.shareOnTap,
    this.followed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: TextButton(
              onPressed: readOnTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  context.atheme.buttonColor,
                ),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.white24;
                    }
                  },
                ),
                minimumSize: MaterialStateProperty.all(
                  const Size(double.infinity, double.infinity),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: context.atheme.standardBorderRadius,
                  ),
                ),
              ),
              child: Text(
                "#read".tr.capitalize!,
                style: context.atheme.titleTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10.sp),
              child: OutlinedButton(
                onPressed: (followed != null) ? bookmarkOnTap : null,
                child: (followed != null)
                    ? Icon(
                        PhosphorIcons.heartBold,
                        size: 22.sp,
                        color: context.atheme.iconColor,
                      )
                    : Center(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: CircularProgressIndicator(
                            color: context.atheme.buttonColor,
                          ),
                        ),
                      ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, double.infinity)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: context.atheme.standardBorderRadius,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10.sp),
              child: OutlinedButton(
                onPressed: bookmarkOnTap,
                child: Icon(
                  PhosphorIcons.shareNetworkBold,
                  size: 22.sp,
                  color: context.atheme.iconColor,
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, double.infinity),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: context.atheme.standardBorderRadius,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final ImageProvider img;
  const _Image({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 225 / 348,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: context.atheme.standardBorderRadius,
        ),
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
                  color: context.atheme.buttonColor,
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

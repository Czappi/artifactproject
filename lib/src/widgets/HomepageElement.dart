import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomepageElement extends StatelessWidget {
  final String title, subtitle;
  final GestureTapCallback? onShowMore;
  final Color backgroundColor;
  final Widget child;
  const HomepageElement({
    Key? key,
    required this.title,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.subtitle = "",
    this.onShowMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70.h,
            padding: const EdgeInsets.fromLTRB(15, 18, 15, 12),
            child: Row(
              children: [
                _TitleSubtitle(
                  title: title,
                  subtitle: subtitle,
                ),
                _ShowMore(
                  onShowMore: onShowMore,
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _ShowMore extends StatelessWidget {
  final GestureTapCallback? onShowMore;
  const _ShowMore({Key? key, this.onShowMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (onShowMore != null) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onShowMore,
            child: Row(
              children: [
                Text(
                  "#showmore".tr.capitalizeFirst!,
                  style: context.atheme.mlsubtitleTextStyle
                      .copyWith(fontSize: 12.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Icon(
                  PhosphorIcons.caretRightBold,
                  color: context.atheme.iconColor,
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

class _TitleSubtitle extends StatelessWidget {
  final String title, subtitle;
  const _TitleSubtitle({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.atheme.mltitleTextStyle,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                subtitle,
                style: context.atheme.mlsubtitleTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

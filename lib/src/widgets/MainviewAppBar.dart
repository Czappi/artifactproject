import 'package:artifactproject/src/utils/Greeting.dart';
import 'package:artifactproject/src/widgets/shared/UserAvatar.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';

class MainviewAppBar extends StatelessWidget {
  final String? userImageUrl;
  final String username;
  final GestureTapCallback? searchOnTap, notificationOnTap;
  const MainviewAppBar({
    Key? key,
    this.username = "undefined",
    this.userImageUrl,
    this.notificationOnTap,
    this.searchOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.all(8.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(userImageUrl: userImageUrl),
          Expanded(
            child: _TitleText(
              username: username,
            ),
          ),
          IconButton(
            onPressed: searchOnTap,
            icon: Icon(
              PhosphorIcons.magnifyingGlassBold,
              size: 26.sp,
              color: context.atheme.iconColor,
            ),
          ),
          IconButton(
            onPressed: notificationOnTap,
            icon: Icon(
              PhosphorIcons.bellBold,
              size: 26.sp,
              color: context.atheme.iconColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String username;
  const _TitleText({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            greeting().tr.capitalize! + ",",
            style: context.atheme.mlsubtitleTextStyle,
          ),
          Text(
            username,
            style: context.atheme.mltitleTextStyle.copyWith(fontSize: 18.sp),
          ),
        ],
      ),
    );
  }
}

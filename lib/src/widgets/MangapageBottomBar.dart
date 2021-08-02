import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:get/get.dart';

class MangapageBottomBar extends StatelessWidget {
  final GestureTapCallback? onTap;
  const MangapageBottomBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      color: context.atheme.backgroundColor,
      padding: EdgeInsets.fromLTRB(20.sp, 15.sp, 20.sp, 15.sp),
      child: _Button(onTap: onTap),
    );
  }
}

class _Button extends StatelessWidget {
  final GestureTapCallback? onTap;
  const _Button({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(context.atheme.buttonColor),
        overlayColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.white24;
          }
        }),
        minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, double.infinity)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: context.atheme.standardBorderRadius,
          ),
        ),
        alignment: Alignment.center,
      ),
      child: Text(
        "#readnow".tr.capitalize!,
        style: context.atheme.titleTextStyle.copyWith(
          fontSize: 16.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}

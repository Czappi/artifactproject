import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';

class MangapageCard extends StatelessWidget {
  final Widget child;
  const MangapageCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.sp),
      padding: EdgeInsets.fromLTRB(16.sp, 22.sp, 16.sp, 16.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.atheme.cardColor,
        borderRadius: context.atheme.standardBorderRadius,
      ),
      child: child,
    );
  }
}

import 'package:artifactproject/src/providers/NavigationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class MangapageAppbar extends StatelessWidget {
  final GestureTapCallback? settingsOnTap;
  const MangapageAppbar({Key? key, this.settingsOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      color: context.atheme.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 5.sp),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            IconButton(
              onPressed: () async {
                await context
                    .read<NavigationProvider>()
                    .panelController
                    .close();
                await context.read<NavigationProvider>().panelController.hide();
              },
              icon: Icon(
                PhosphorIcons.caretLeftBold,
                size: 26.sp,
                color: context.atheme.iconColor,
              ),
            ),
            Expanded(child: Container()),
            IconButton(
              onPressed: settingsOnTap,
              icon: Icon(
                PhosphorIcons.dotsThreeOutlineBold,
                size: 26.sp,
                color: context.atheme.iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

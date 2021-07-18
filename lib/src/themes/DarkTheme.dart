import 'package:artifactproject/src/themes/ArtifactTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// = const Color.fromARGB(255, )
class DarkTheme extends ArtifactTheme {
  DarkTheme();

  @override
  final Color backgroundColor = const Color.fromARGB(254, 4, 4, 4);
  @override
  final Color cardColor = const Color.fromARGB(255, 31, 31, 31);
  @override
  final Color buttonColor = const Color.fromARGB(255, 0, 170, 210);
  @override
  final Color disabledIconColor = const Color.fromARGB(255, 128, 128, 128);
  @override
  final Color iconColor = const Color.fromARGB(255, 245, 245, 245);
  @override
  final Color starColor = const Color.fromARGB(255, 242, 201, 78);

  /// title of a MangaList item
  @override
  final TextStyle mltitleTextStyle = GoogleFonts.roboto(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.sp,
  );

  /// subtitle of a MangaList item
  @override
  final TextStyle mlsubtitleTextStyle = GoogleFonts.roboto(
    color: const Color(0xFFc4c6c8),
    fontWeight: FontWeight.w500,
    fontSize: 11.sp,
  );

  /// title of manga in a MangaPage
  @override
  final TextStyle titleTextStyle = const TextStyle();

  /// subtitle of manga in a MangaPage
  @override
  final TextStyle subtitleTextStyle = const TextStyle();

  /// description
  @override
  final TextStyle bodyTextStyle = const TextStyle();

  /// title in description
  @override
  final TextStyle bodyTitleTextStyle = const TextStyle();

  /// subtitle in description
  @override
  final TextStyle bodySubtitleTextStyle = const TextStyle();

  /// System theme for statusbar
  @override
  final SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,
    statusBarColor: Color(0x00000000),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );
}

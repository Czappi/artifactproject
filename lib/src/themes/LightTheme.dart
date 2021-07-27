import 'package:artifactproject/src/providers/SettingsProvider.dart';
import 'package:artifactproject/src/themes/ArtifactTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// = const Color.fromARGB(255, )
class LightTheme extends ArtifactTheme {
  LightTheme();

  @override
  ThemeOption get themeOption => ThemeOption.light;

  @override
  final Color backgroundColor = Colors.white;
  @override
  final Color cardColor = Colors.white70;
  @override
  final Color buttonColor = const Color.fromARGB(255, 0, 170, 210);
  @override
  final Color disabledIconColor = const Color.fromARGB(255, 128, 128, 128);
  @override
  final Color iconColor = Colors.black87;
  @override
  final Color starColor = const Color.fromARGB(255, 242, 201, 78);

  /// title of a MangaList item
  @override
  final TextStyle mltitleTextStyle = GoogleFonts.roboto(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20.sp,
  );

  /// subtitle of a MangaList item
  @override
  final TextStyle mlsubtitleTextStyle = GoogleFonts.roboto(
    color: Colors.black45,
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
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}

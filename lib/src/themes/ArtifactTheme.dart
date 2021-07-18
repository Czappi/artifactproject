import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ArtifactTheme {
  const ArtifactTheme();

  abstract final Color backgroundColor;
  abstract final Color cardColor;
  abstract final Color buttonColor;
  abstract final Color disabledIconColor;
  abstract final Color iconColor;
  abstract final Color starColor;

  /// title of a MangaList item
  abstract final TextStyle mltitleTextStyle;

  /// subtitle of a MangaList item
  abstract final TextStyle mlsubtitleTextStyle;

  /// title of manga in a MangaPage
  abstract final TextStyle titleTextStyle;

  /// subtitle of manga in a MangaPage
  abstract final TextStyle subtitleTextStyle;

  /// description
  abstract final TextStyle bodyTextStyle;

  /// title in description
  abstract final TextStyle bodyTitleTextStyle;

  /// subtitle in description
  abstract final TextStyle bodySubtitleTextStyle;

  /// System theme for statusbar
  abstract final SystemUiOverlayStyle systemUiOverlayStyle;

  final BorderRadius standardBorderRadius =
      const BorderRadius.all(Radius.circular(12));
}

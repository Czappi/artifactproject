import 'package:artifactproject/src/themes/ArtifactTheme.dart';
import 'package:artifactproject/src/themes/DarkTheme.dart';
import 'package:artifactproject/src/themes/LightTheme.dart';
import 'package:artifactproject/src/utils/SharedPrefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ThemeOption { light, dark, device }
enum DiscoverStyleOption { grid, list }

class SettingsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  BuildContext context;
  SettingsProvider(this.context);

  final SharedPrefs _prefs = SharedPrefs();

  static const String _settingsPrefix = "settings_";

  // themeOption
  final String _themeOptionKey = _settingsPrefix + "themeoption";

  ThemeOption? _themeOption;
  final DarkTheme _darkTheme = DarkTheme();
  final LightTheme _lightTheme = LightTheme();

  Future<void> setThemeOption(ThemeOption themeOption) async {
    await _prefs.setInt(_themeOptionKey, themeOption.index);
    _themeOption = themeOption;
    notifyListeners();
  }

  ThemeOption getThemeOption() {
    var to = ThemeOption.values[_prefs.getInt(_themeOptionKey) ?? 2];
    _themeOption = to;
    return to;
  }

  ThemeOption get themeOption => _themeOption ?? getThemeOption();

  ArtifactTheme get theme {
    switch (_themeOption) {
      case ThemeOption.dark:
        return _darkTheme;
      case ThemeOption.light:
        return _lightTheme;
      case ThemeOption.device:
        return Theme.of(context).brightness == Brightness.light
            ? _lightTheme
            : _darkTheme;
      default:
        return _lightTheme;
    }
  }

  // discover style
  final String _discoverStyleOptionKey = _settingsPrefix + "discoverStyle";

  DiscoverStyleOption? _discoverStyleOption;

  Future<void> setDiscoverStyleOption(
      DiscoverStyleOption discoverStyleOption) async {
    await _prefs.setInt(_discoverStyleOptionKey, discoverStyleOption.index);
    _discoverStyleOption = discoverStyleOption;
    notifyListeners();
  }

  DiscoverStyleOption getDiscoverStyleOption() {
    var to =
        DiscoverStyleOption.values[_prefs.getInt(_discoverStyleOptionKey) ?? 0];
    _discoverStyleOption = to;
    return to;
  }

  DiscoverStyleOption get discoverStyle =>
      _discoverStyleOption ?? getDiscoverStyleOption();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<ThemeOption>('ThemeOption', _themeOption,
        defaultValue: null));
  }
}

extension ThemeContextExtension on BuildContext {
  ArtifactTheme get atheme => watch<SettingsProvider>().theme;
}

import 'package:artifactproject/src/translations/en_US.dart';
import 'package:get/get.dart';

class ArtifactTranslations extends Translations {
  Map<String, Map<String, String>> get keys {
    Map<String, Map<String, String>> langs = {};

    langs.addAll({"en_US": en_US});

    return langs;
  }
}

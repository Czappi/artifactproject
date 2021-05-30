import 'package:equatable/equatable.dart';
import 'package:artifactproject/src/utils/FormatUtils.dart';

class Chapter extends Equatable {
  final String title, href;
  final DateTime uploaded;
  final int view;

  const Chapter(this.title, this.uploaded, this.view, this.href);

  static Chapter fromStrings(
      String title, String uploaded, String view, String href) {
    return Chapter(
      title,
      FormatUtils.formatDate(uploaded),
      FormatUtils.formatView(view),
      href,
    );
  }

  @override
  List<Object> get props => [title, href, uploaded, view];
}

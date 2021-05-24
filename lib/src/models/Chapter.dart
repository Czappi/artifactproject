import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Chapter extends Equatable {
  final String title, href;
  final DateTime uploaded;
  final int view;

  const Chapter(this.title, this.uploaded, this.view, this.href);

  static Chapter fromStrings(
      String title, String uploaded, String view, String href) {
    return Chapter(
      title,
      DateFormat("MMM dd,yyyy hh:mm").parse(uploaded),
      int.parse(view.replaceAll(",", "")),
      href,
    );
  }

  @override
  List<Object> get props => [];
}

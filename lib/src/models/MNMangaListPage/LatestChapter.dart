import 'package:equatable/equatable.dart';

class LatestChapter extends Equatable {
  final String title, url;

  const LatestChapter(this.title, this.url);

  @override
  List<Object?> get props => [title, url];
}
